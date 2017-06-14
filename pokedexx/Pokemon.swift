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
    
    func getPokeStats() -> PokemonStats? {
        if let index2 = PokemonDao.shared.pokemonStats.index(where: { $0.id == self.id }) {
            return PokemonDao.shared.pokemonStats[index2]
        }
        else {
            Parser.shared.parsePokemonStats(byID: self.id)
            if let index2 = PokemonDao.shared.pokemonStats.index(where: { $0.id == self.id }) {
                return PokemonDao.shared.pokemonStats[index2]
            }
            else {
                return nil
            }
        }
    }
    
    func getEvolutionChain(chainID: Int32) -> [Pokemon]? {
        var arr = [Pokemon]()
        var sortedChain = [PokemonDetail]()
        
        let chain = PokemonDao.shared.pokeDetailCache.filter { pk in
            return (pk.evolution_chain == chainID)
        }
        for item in chain {
            print(item)
            if item.evolve_from_speciesID == 0{
                sortedChain.insert(item, at: 0)
            }
            else {
                print("sorted chain \(sortedChain) ")
                var evolveFromSpeciesIndex = -1
                for (index, element) in sortedChain.enumerated() {
                    if element.speciesID == item.evolve_from_speciesID {
                        evolveFromSpeciesIndex = index
                        break
                    }
                }
                print(evolveFromSpeciesIndex)
                if evolveFromSpeciesIndex == -1 {
                    print("-1 index")
                    sortedChain.append(item)
                }
                else {
                    evolveFromSpeciesIndex += 1
                    sortedChain.insert(item, at: evolveFromSpeciesIndex)
                }
            }
        }
        
        
        for item in sortedChain {
            let poke = PokemonDao.shared.pokedexCache.filter { p in
                return (p.speciesID == item.speciesID)
            }
            if poke.count > 0{
                arr.append(poke.first!)
            }
        }
        
        return arr
    }
    
    func getMegaEvolutionChain() -> [Pokemon]? {
        let chain = PokemonDao.shared.pokedexCache.filter { p in
            return (p.speciesID == self.speciesID)
        }
        
        if chain.count > 0 {
            return chain
        }
        else {
            return nil
        }
    }
}
