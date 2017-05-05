//
//  Enums.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class Enums{
    enum PokemonType : Int {
        case Normal = 1
        case Fighting = 2
        case Flying = 3
        case Poison = 4
        case Ground = 5
        case Rock = 6
        case Bug = 7
        case Ghost = 8
        case Steel = 9
        case Fire = 10
        case Water = 11
        case Grass = 12
        case Electric = 13
        case Psychic = 14
        case Ice = 15
        case Dragon = 16
        case Dark = 17
        case Fairy = 18
        case Unkown = 10001
        case None = 10002
        
        var desc : String {
            switch self {
            case .Normal:
                return "Normal"
            case .Fighting:
                return "Fighting"
            case .Flying:
                return "Flying"
            case .Poison:
                return "Poison"
            case .Ground:
                return "Ground"
            case .Rock:
                return "Rock"
            case .Bug:
                return "Bug"
            case .Ghost:
                return "Ghost"
            case .Steel:
                return "Steel"
            case .Fire:
                return "Fire"
            case .Water:
                return "Water"
            case .Grass:
                return "Grass"
            case .Electric:
                return "Electric"
            case .Psychic:
                return "Psychic"
            case .Ice:
                return "Ice"
            case .Dragon:
                return "Dragon"
            case .Dark:
                return "Dark"
            case .Fairy:
                return "Fairy"
            case .Unkown:
                return "Unkown"
            case .None:
                return "None"
            }
        }
    }
    
    enum CapsuleType: String {
        case ID
        case PokeType
        case Species
        case Ability
        case AbilityHidden
    }

}
