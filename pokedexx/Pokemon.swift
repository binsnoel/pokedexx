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
            Parser().parsePokemonDetail(byID: self.speciesID)
            if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == self.speciesID }) {
                return PokemonDao.shared.pokeDetailCache[index2]
            }
            else {
                return nil
            }
        }

    }
    
    func getEvolutionChain(chainID: Int32) -> [Pokemon]? {
        var arr = [Pokemon]()
        let chain = PokemonDao.shared.pokeDetailCache.filter { pk in
            return (pk.evolution_chain == chainID)
        }
        
        for item in chain {
            let poke = PokemonDao.shared.pokedexCache.filter { p in
                return (p.speciesID == item.speciesID)
            }
            
            if poke.count > 0{
                arr.append(poke.first!)
            }
        }
        
        print(arr)
        return arr
    }
}
