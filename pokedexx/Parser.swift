//
//  Parser.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import CSwiftV

class Parser: NSObject{
    
    func parsePokemon() {
        do {
            let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
            let pokemons = try CSwiftV(with: String(contentsOfFile: path!, encoding: String.Encoding.utf8))
            
            let typePath = Bundle.main.path(forResource: "pokemon_types", ofType: "csv")
            let types = try CSwiftV(with: String(contentsOfFile: typePath!, encoding: String.Encoding.utf8))
            
            let speciesPath = Bundle.main.path(forResource: "pokemon_species_names", ofType: "csv")
            let species = try CSwiftV(with: String(contentsOfFile: speciesPath!, encoding: String.Encoding.utf8))
            
            for row in pokemons.rows {
                
                //get pokemon types
                let pokemonType = types.rows.filter{
                    return $0["pokemon_id"] == row["id"]
                }
                var a = "10002"
                var b = "10002"
                
                if let typeA = pokemonType.first?["type_id"] {
                    a = typeA
                }
                if pokemonType.count > 1 {
                    if let typeB = pokemonType.last?["type_id"] {
                        b = typeB
                    }
                }
                
                //get pokemon genus/description
                var gen = ""
                let genus = species.rows.filter{
                    return $0["pokemon_species_id"] == row["species_id"] && $0["local_language_id"] == "9"
                }
                if let genu = genus.first?["genus"] {
                    gen = genu
                }
                
                PokemonDao.shared.addPokemon(id: Int32(row["id"]!)!,
                                             order: Int32(row["order"]!)!,
                                             name: Common.formatName(row["identifier"]!),
                                             typeA: a,
                                             typeB: b,
                                             height: Int32(row["height"]!)!,
                                             weight: Int32(row["weight"]!)!,
                                             baseExp: Int32(row["base_experience"]!)!,
                                             species: Int32(row["species_id"]!)!,
                                             genus: gen)
                
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(true, forKey: "hasLoaded")
            userDefaults.synchronize()
            
            PokemonDao.shared.refreshPokedexCache()
        } catch {
            // Error handling
            //alert view
        }
    }
    
    func parsePokemonDetail(byID: Int32){
        do {
            let path = Bundle.main.path(forResource: "pokemon_species_flavor_text", ofType: "csv")
            let details = try CSwiftV(with: String(contentsOfFile: path!, encoding: String.Encoding.utf8))
            
            let detail = details.rows.filter{
                return $0["species_id"] == String(byID) && $0["version_id"] == "1" && $0["language_id"] == "9"
            }
            
            if detail.count > 0 {
                let flavor_text = detail.first?["flavor_text"]
                PokemonDao.shared.addPokemonDetail(speciesID: byID, desc: flavor_text!)
                PokemonDao.shared.refreshPokeDetailCache()
            }
            else{
                //notify UI that parsing failed and display error message
            }
            
        }
        catch {
            // Error handling
            //alertview
        }
    }

}
