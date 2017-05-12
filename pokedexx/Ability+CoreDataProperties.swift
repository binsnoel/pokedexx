//
//  Ability+CoreDataProperties.swift
//  
//
//  Created by binsnoel on 13/05/2017.
//
//

import Foundation
import CoreData


extension Ability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ability> {
        return NSFetchRequest<Ability>(entityName: "Ability")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
