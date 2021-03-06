//
//  Common.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class Common {
    
    //Returns corresponding UIColor of Pokemon Type parameter
    public static func getTypeColor(_ type:Enums.PokemonType) -> UIColor {
        switch type {
            case .Normal:
                return UIColor.pkNormalColor
            case .Fighting:
                return UIColor.pkFightingColor
            case .Flying:
                return UIColor.pkFlyingColor
            case .Poison:
                return UIColor.pkPoisonColor
            case .Ground:
                return UIColor.pkGroundColor
            case .Bug:
                return UIColor.pkBugColor
            case .Ghost:
                return UIColor.pkGhostColor
            case .Rock:
                return UIColor.pkRockColor
            case .Steel:
                return UIColor.pkSteelColor
            case .Fire:
                return UIColor.pkFireColor
            case .Water:
                return UIColor.pkWaterColor
            case .Grass:
                return UIColor.pkGrassColor
            case .Electric:
                return UIColor.pkElectricColor
            case .Psychic:
                return UIColor.pkPsychicColor
            case .Ice:
                return UIColor.pkIceColor
            case .Dragon:
                return UIColor.pkDragonColor
            case .Dark:
                return UIColor.pkDarkColor
            case .Fairy:
                return UIColor.pkFairyColor
            case .Unkown:
                return UIColor.pkUnkownColor
            case .None:
                return UIColor.clear
        }
    }
    
    //Format string ID to #XXX (3 digit number)
    public static func format(forId: Int32) -> String{
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        return "#" + formatter.string(from: NSNumber(value:(forId)))!
        
    }
    
    //Format pokemon names
    public static func formatName(_ forName: String) -> String {
        let toArray = forName.components(separatedBy: "-")
        var arr = [String]()
        for word in toArray {
            arr.append(word.capitalized)
        }
        let backToString = arr.joined(separator: " ")
        
        return backToString//forName.replacingOccurrences(of: "-", with: " ")
    }
    
}
