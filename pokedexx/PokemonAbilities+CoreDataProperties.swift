//
//  PokemonAbilities+CoreDataProperties.swift
//  
//
//  Created by binsnoel on 13/05/2017.
//
//

import Foundation
import CoreData


extension PokemonAbilities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonAbilities> {
        return NSFetchRequest<PokemonAbilities>(entityName: "PokemonAbilities")
    }

    @NSManaged public var ability_id: Int32
    @NSManaged public var desc: String?
    @NSManaged public var poke_id: Int32
    @NSManaged public var isHidden: Bool
    @NSManaged public var slot: Int32

}
