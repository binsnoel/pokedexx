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
    var pokeDetailCache: Array<PokemonDetail>

    
    public static let shared = PokemonDao()
    
    private override init() {
        pokedexCache = PokemonDao.getAll()!
        pokeDetailCache = PokemonDao.getAllDetails()!
    }
    
    func refreshPokedexCache() {
        pokedexCache = PokemonDao.getAll()!
    }
    
    // Pokemon Functions

    func addPokemon(id:Int32,
                    order:Int32,
                    name:String,
                    typeA:String = "None",
                    typeB:String = "None",
                    height:Int32,
                    weight: Int32,
                    baseExp: Int32,
                    species: Int32,
                    genus: String) {
        if let p = getPokemon(byId: id) {
            p.order = order
            p.name = name
            p.typeA = typeA
            p.typeB = typeB
            p.height = height
            p.weight = weight
            p.baseExp = baseExp
            p.speciesID = species
            p.genus = genus
            print("\(name) existing")
        } else {
            if let context = DataManager.shared.objectContext {
                let p = Pokemon(context: context)
                p.id = id
                p.order = order
                p.name = name
                p.typeA = typeA
                p.typeB = typeB
                p.height = height
                p.weight = weight
                p.baseExp = baseExp
                p.speciesID = species
                p.genus = genus
                try? context.save()
                print("Added \(name)")
            }
        }
    }
    
    class func getAll() -> [Pokemon]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            let arr = [ NSSortDescriptor(key: "speciesID", ascending: true),
                        NSSortDescriptor(key: "order", ascending: true)]
            request.sortDescriptors = arr
            if let pokemons = try? context.fetch(request) {
                return pokemons
            }
        }
        return nil
    }
    
    func getPokemon(byId: Int32) -> Pokemon? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            request.predicate = NSPredicate(format: "id==%d", byId)
            if let pokemons = try? context.fetch(request) {
                return pokemons.first
            }
        } else {
            return self.pokedexCache[Int(byId)]
        }
        return nil
    }
    
    
    
    
    
    
    
    
    //Pokemon Detail functions
    
    func addPokemonDetail(speciesID:Int32,
                          desc:String) {
        
        if let p = getPokemonDetail(bySpeciesId: speciesID) {
            p.desc = desc
            print("pokemon detail \(speciesID): existing")
        } else {
            if let context = DataManager.shared.objectContext {
                let p = PokemonDetail(context: context)
                p.speciesID = speciesID
                p.desc = desc
                try? context.save()
                print("Added Detail \(speciesID)")
            }
        }
    }
    
    func getPokemonDetail(bySpeciesId: Int32) -> PokemonDetail? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<PokemonDetail> = PokemonDetail.fetchRequest()
            request.predicate = NSPredicate(format: "speciesID==%d", bySpeciesId)
            if let pokemons = try? context.fetch(request) {
                return pokemons.first
            }
        }
        
        return nil
    }
    
    class func getAllDetails() -> [PokemonDetail]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<PokemonDetail> = PokemonDetail.fetchRequest()
            if let pokemons = try? context.fetch(request) {
                return pokemons
            }
        }
        return nil
    }
    
    func refreshPokeDetailCache() {
        self.pokeDetailCache = PokemonDao.getAllDetails()!
    }
    
    
    
    
}
