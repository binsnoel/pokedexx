//
//  UIColor+Hex.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

extension UIColor {
    /*
     * Pokemon Type Colors
     */
    static let pkNormalColor = UIColor(netHex: 0xa8a878)
    static let pkFightingColor = UIColor(netHex: 0xc03028)
    static let pkFlyingColor = UIColor(netHex: 0xa890f0)
    static let pkPoisonColor = UIColor(netHex: 0xa040a0)
    static let pkGroundColor = UIColor(netHex: 0xe0c068)
    static let pkRockColor = UIColor(netHex: 0x4DA664)
    static let pkBugColor = UIColor(netHex: 0xa8b820)
    static let pkGhostColor = UIColor(netHex: 0x705898)
    static let pkSteelColor = UIColor(netHex: 0xb8b8d0)
    static let pkFireColor = UIColor(netHex: 0xf08030)
    static let pkWaterColor = UIColor(netHex: 0x6890f0)
    static let pkGrassColor = UIColor(netHex: 0x4DA664)
    static let pkElectricColor = UIColor(netHex: 0xf8d030)
    static let pkPsychicColor = UIColor(netHex: 0xf85888)
    static let pkIceColor = UIColor(netHex: 0x98d8d8)
    static let pkDragonColor = UIColor(netHex: 0x7038f8)
    static let pkDarkColor = UIColor(netHex: 0x705848)
    static let pkFairyColor = UIColor(netHex: 0xee99ac)
    static let pkUnkownColor = UIColor(netHex: 0x2CA786)
    
    
    static let pkPokeIDColor = UIColor(netHex: 0xececec)
    static let pkPokeNavBarRed     = UIColor(netHex: 0xee4208)
    static let pkPokeRed     = UIColor(netHex: 0xee4208)
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
