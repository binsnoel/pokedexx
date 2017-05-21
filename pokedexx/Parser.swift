//
//  Parser.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

protocol ParserDelegate : class {
    func didFinishParsingPokemon()
}

class Parser{
    public static let shared = Parser()
    weak var delegate:ParserDelegate?
    
    func parsePokemon() {
        do {
            let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
            let pokemons = try CSV(contentsOfURL: path!)
            
            let typePath = Bundle.main.path(forResource: "pokemon_types", ofType: "csv")
            let types = try CSV(contentsOfURL: typePath!)
            
            let speciesPath = Bundle.main.path(forResource: "pokemon_species_names", ofType: "csv")
            let species = try CSV(contentsOfURL: speciesPath!)
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
            
            DispatchQueue.main.async(execute: {
                self.delegate?.didFinishParsingPokemon()
            })
        } catch {
            // Error handling
            //alert view
        }
    }
    
    func parsePokemonDetail(){
        do {
            
            let path1 = Bundle.main.path(forResource: "pokemon_species", ofType: "csv")
            let pokeSpecies = try CSV(contentsOfURL: path1!)
//            let specs = pokeSpecies.rows.filter{
//                return $0["id"] == String(byID)
//            }
            
            for specs in pokeSpecies.rows {
                let echain = specs["evolution_chain_id"]!
                let efrom = specs["evolves_from_species_id"]! == "" ? "0" : specs["evolves_from_species_id"]!
                
                PokemonDao.shared.addPokemonDetail(speciesID: Int32(specs["id"]!)!,
                                                   desc: "-",
                                                   evoChain:Int32(echain)!,
                                                   evoFrom: Int32(efrom)!)
            }
            
            PokemonDao.shared.refreshPokeDetailCache()
        }
        catch {
            // Error handling
            //alertview
        }
    }
    
    func parsePokeEntry(speciesID: Int32){
        do {
            let path = Bundle.main.path(forResource: "pokemon_species_flavor_text", ofType: "csv")
            let details = try CSV(contentsOfURL: path!)
            
            var flavor_text : String?
            let detail = details.rows.filter{
                return $0["species_id"] == String(speciesID) && $0["language_id"] == "9"
            }
            
            if detail.count > 0 {
                flavor_text = detail.first?["flavor_text"]!
            }
            else {
                flavor_text = ""
            }
            
            PokemonDao.shared.addPokeEntry(speciesID: speciesID,
                                           desc: flavor_text!)
            
            PokemonDao.shared.refreshPokeDetailCache()
        }
        catch {
            
        }

    }

    func parseAbility() {
        do {
            let path = Bundle.main.path(forResource: "abilities", ofType: "csv")
            let abilities = try CSV(contentsOfURL: path!)
            
            for row in abilities.rows {
                PokemonDao.shared.addAbility(ID: Int32(row["id"]!)!, Name: row["identifier"]!)
            }
        }
        catch {
            // Error handling
            //alertview
        }
    }
    
    
    func parsePokemonAbilities() {
        do {
            let path = Bundle.main.path(forResource: "pokemon_abilities", ofType: "csv")
            let poke_abilities = try CSV(contentsOfURL: path!)
            
            let path2 = Bundle.main.path(forResource: "abilities", ofType: "csv")
            let abilities = try CSV(contentsOfURL: path2!)
            
            for row in poke_abilities.rows {
                
                let desc = abilities.rows.filter{
                    return $0["id"] == row["ability_id"]
                }
                var gen = ""
                if let genu = desc.first?["identifier"] {
                    gen = genu
                }

                let hdn = (row["is_hidden"] == "1") ? true : false
                
                PokemonDao.shared.addPokemonAbility(poke_id: Int32(row["pokemon_id"]!)!,
                                                    ability_id: Int32(row["ability_id"]!)!,
                                                    desc: gen,
                                                    isHidden: hdn,
                                                    slot: Int32(row["slot"]!)!)
            }
            
            PokemonDao.shared.refreshPokeAbilitiesCache()
            
        }
        catch {
            // Error handling
            //alertview
        }
    }
}
