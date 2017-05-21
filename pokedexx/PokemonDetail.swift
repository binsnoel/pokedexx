//
//  PokemonDetail+CoreDataClass.swift
//  
//
//  Created by binsnoel on 08/05/2017.
//
//

import Foundation
import CoreData


public class PokemonDetail: NSManagedObject {
    
    func getDetailBySpeciesID(_ speciesID: Int32) -> PokemonDetail? {
        if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == speciesID }) {
            return PokemonDao.shared.pokeDetailCache[index2]
        }
        else {
//            Parser().parsePokemonDetail(byID: speciesID)
            return nil
        }
    }
}
