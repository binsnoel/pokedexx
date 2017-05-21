//
//  Pokemon+CoreDataClass.swift
//  
//
//  Created by binsnoel on 08/05/2017.
//
//

import Foundation
import CoreData


public class Pokemon: NSManagedObject {
    
    func getDetails() -> PokemonDetail?{
        if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == self.speciesID }) {
             return PokemonDao.shared.pokeDetailCache[index2]
        }
        else {
            return nil
        }
    }
    
    func getPokeEntry() -> String{
        if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == self.speciesID }) {
            let x = PokemonDao.shared.pokeDetailCache[index2].desc!
            if x != "-" {
                return x
            }
            else {
                Parser.shared.parsePokeEntry(speciesID: self.speciesID)
                
                if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == self.speciesID }) {
                    let x = PokemonDao.shared.pokeDetailCache[index2].desc!
                    if x != "-" {
                        return x
                    }
                    else {
                        return ""
                    }
                }
                else {
                    return ""
                }
            }
        }
        return ""
    }
    
    func getEvolutionChain(chainID: Int32) -> [Pokemon]? {
        var arr = [Pokemon]()
        var sortedChain = [PokemonDetail]()
        
        let chain = PokemonDao.shared.pokeDetailCache.filter { pk in
            return (pk.evolution_chain == chainID)
        }
//        print(chain)
        var count = -1
        for item in chain {
            print(item)
            if item.evolve_from_speciesID == 0{
                sortedChain.insert(item, at: 0)
            }
            else {
                print("sorted chain \(sortedChain) ")
                if var index = sortedChain.index(where: { $0.speciesID == item.evolve_from_speciesID }) {
                    index = index == 0 ? 0 : (index + 1)
                    sortedChain.insert(item, at: index)
                }
                else {
                    sortedChain.insert(item, at: count + 1)
                }
            }
            count += 1
        }
        
        
        for item in chain {
            let poke = PokemonDao.shared.pokedexCache.filter { p in
                return (p.speciesID == item.speciesID)
            }
            
            if poke.count > 0{
                arr.append(poke.first!)
            }
        }
        
        return arr
    }
}
