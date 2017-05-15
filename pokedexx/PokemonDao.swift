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
    var pokedexCache: Array<Pokemon>
    var pokeDetailCache: Array<PokemonDetail>
    var abilitiesCache: Array<Ability>
    var pokemonAbilities: Array<PokemonAbilities>
    
    public static let shared = PokemonDao()
    
    private override init() {
        pokedexCache = PokemonDao.getAll()!
        pokeDetailCache = PokemonDao.getAllDetails()!
        abilitiesCache = PokemonDao.getAllAbilities()!
        pokemonAbilities = PokemonDao.getAllPokemonAbilities()!
    }
    
    func refreshPokedexCache() {
        pokedexCache = PokemonDao.getAll()!
    }
    
    // MARK: - Pokemon Functions

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
    
    
    // MARK: - Pokemon Detail functions
    
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
    
    
    // MARK: - Abilities functions
    
    func addAbility(ID: Int32, Name: String){
        if let p = getAbility(withID: ID) {
            p.name = Name
            print("ability \(Name): existing")
        } else {
            if let context = DataManager.shared.objectContext {
                let p = Ability(context: context)
                p.id = ID
                p.name = Name
                try? context.save()
                print("Added Detail \(Name)")
            }
        }
    }
    
    func getAbility(withID: Int32) -> Ability? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Ability> = Ability.fetchRequest()
            request.predicate = NSPredicate(format: "id==%d", withID)
            if let abilities = try? context.fetch(request) {
                return abilities.first
            }
        }
        
        return nil
    }
    
    class func getAllAbilities() -> [Ability]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<Ability> = Ability.fetchRequest()
            if let abilities = try? context.fetch(request) {
                return abilities
            }
        }
        return nil
    }
    
    // MARK: - Pokemon Abilities functions
    func addPokemonAbility(poke_id:Int32,
                          ability_id:Int32,
                          desc: String,
                          isHidden: Bool,
                          slot: Int32) {
        
        if let p = getPokemonAbility(byId: poke_id, byAbilityId: ability_id) {
            p.desc = desc
            p.slot = slot
            p.isHidden = isHidden
            print("pokemon ability \(ability_id) for pokemon \(poke_id) existing")
        } else {
            if let context = DataManager.shared.objectContext {
                let p = PokemonAbilities(context: context)
                p.desc = desc
                p.slot = slot
                p.isHidden = isHidden
                p.poke_id = poke_id
                p.ability_id = ability_id
                try? context.save()
                print("Added pokemon ability: \(ability_id) for: \(poke_id)")
            }
        }
    }

    func getPokemonAbility(byId: Int32, byAbilityId: Int32) -> PokemonAbilities? {
        
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<PokemonAbilities> = PokemonAbilities.fetchRequest()
            request.predicate = NSPredicate(format: "(poke_id==%d) AND (ability_id==%d)", byId, byAbilityId)
            if let pokemonAbilities = try? context.fetch(request) {
                return pokemonAbilities.first
            }
        }
        
        return nil
    }
    
    class func getAllPokemonAbilities() -> [PokemonAbilities]? {
        if let context = DataManager.shared.objectContext {
            let request: NSFetchRequest<PokemonAbilities> = PokemonAbilities.fetchRequest()
            if let pokemonAbilities = try? context.fetch(request) {
                return pokemonAbilities
            }
        }
        return nil
    }

    func refreshPokeAbilitiesCache() {
        self.pokemonAbilities = PokemonDao.getAllPokemonAbilities()!
    }
    

    
}
