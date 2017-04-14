//
//  Parser.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import SwiftyJSON

class Parser: NSObject{
    
    func parseJSONPokedex(json : JSON) {
        var jsonPokedex = [[String:AnyObject]]()
        
        if let resData = json["pokemon_entries"].arrayObject {
            jsonPokedex = resData as! [[String:AnyObject]]
            if jsonPokedex.count > 0 {
                for pokemon in jsonPokedex {
                    
                    if let pokeID = pokemon["entry_number"] as? Int32 {
                        if let pokeName = pokemon["pokemon_species"]?["name"] as? String {
                            print(pokeName + " Added to DB")
                            PokemonDao.shared.addPokemon(poke_ID: pokeID, poke_name: pokeName.capitalized)
                        }
                    }
                }
            }
        }
    }
    
    func parsePokemonData(json: JSON) {
        var typeA = "None"
        var typeB = "None"
        
        if let name = json["name"].string {
            //print(name)
            if let id = json["id"].number {
                //print(id)
                if let slot1 = json["types"][0]["slot"].number{
                    if slot1 == 1 {
                        if let type1 = json["types"][0]["type"]["name"].string{
                            typeA = type1
                            typeB = "None"
                        }
                    }
                    else if slot1 == 2 {
                        if let type1 = json["types"][0]["type"]["name"].string{
                            typeB = type1
                        }
                    }
                }
                if let slot2 = json["types"][1]["slot"].number{
                    if slot2 == 1 {
                        if let type1 = json["types"][1]["type"]["name"].string{
                            typeA = type1
                        }
                    }
                }

                
//                if let type1 = json["types"][1]["type"]["name"].string{
//                    typeB = type1
//                }
//                if let type2 = json["types"][0]["type"]["name"].string{
//                    if typeB == "None" {
//                        typeA = type2
//                    }
//                    else {
//                        typeB = type2
//                    }
//                }
                //print(typeA)
                //print(typeB)
                PokemonDao.shared.addPokemon(poke_ID: Int32(id),
                                           poke_name: name.capitalized,
                                          poke_typeA: typeA.capitalized,
                                          poke_typeB: typeB.capitalized)
                
                PokemonDao.shared.refreshCache()
            }
        }
        
        
    }
}
