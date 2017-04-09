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
        var jsonPokedex = [[String : AnyObject]]()
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
}
