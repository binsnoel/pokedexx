//
//  PokemonDetail+CoreDataProperties.swift
//  
//
//  Created by binsnoel on 08/05/2017.
//
//

import Foundation
import CoreData


extension PokemonDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonDetail> {
        return NSFetchRequest<PokemonDetail>(entityName: "PokemonDetail")
    }

    @NSManaged public var attributej: Int32
    @NSManaged public var desc: String?
    @NSManaged public var speciesID: Int32

}
