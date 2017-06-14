//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by binsnoel on 08/05/2017.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var baseExp: Int32
    @NSManaged public var genus: String?
    @NSManaged public var height: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var order: Int32
    @NSManaged public var speciesID: Int32
    @NSManaged public var typeA: String?
    @NSManaged public var typeB: String?
    @NSManaged public var weight: Int32
    @NSManaged public var switchable: Int32

}
