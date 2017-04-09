//
//  PokemonDao.swift
//  pokedexx
//
//  Created by binsnoel on 02/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import Foundation
import CoreData

class PokemonDao : NSObject {
    var pokedexCache:Array<Pokemon>
    
    public static let shared = PokemonDao()
    
    private override init() {
        pokedexCache = PokemonDao.getAll()!
    }
    
    func refreshCache() {
        pokedexCache = PokemonDao.getAll()!
    }
    
    func addPokemon(poke_ID:Int32, poke_name:String, poke_typeA:String = "None", poke_typeB:String = "None") {
        if let p = getPokemon(byId: poke_ID) {
            p.poke_name = poke_name
            p.poke_typeA = poke_typeA
            p.poke_typeB = poke_typeB
        } else {
            if let context = DataManager.shared.objectContext {
                let p = Pokemon(context: context)
                p.poke_id = poke_ID
                p.poke_name = poke_name
                try? context.save()
            }
        }
    }
    
    class func getAll() -> [Pokemon]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            if let pokemons = try? context.fetch(request) {
//                for p in pokemons {
////                    print(p.poke_name!)
//                }
                return pokemons
            }
        }
        return nil
    }
    
    func getPokemon(byId: Int32) -> Pokemon? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            request.predicate = NSPredicate(format: "poke_id==%d", byId)
            if let pokemons = try? context.fetch(request) {
                return pokemons.first
            }
        } else {
            return self.pokedexCache[Int(byId)]
        }
        return nil
    }
    
}
