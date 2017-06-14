//
//  PokemonStats+CoreDataProperties.swift
//  
//
//  Created by binsnoel on 31/05/2017.
//
//

import Foundation
import CoreData


extension PokemonStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonStats> {
        return NSFetchRequest<PokemonStats>(entityName: "PokemonStats")
    }

    @NSManaged public var id: Int32
    @NSManaged public var hp: Int32
    @NSManaged public var atk: Int32
    @NSManaged public var def: Int32
    @NSManaged public var spAtk: Int32
    @NSManaged public var spDef: Int32
    @NSManaged public var speed: Int32

}
