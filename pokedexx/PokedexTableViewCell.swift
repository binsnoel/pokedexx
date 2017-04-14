//
//  PokedexTableViewCell.swift
//  pokedexx
//
//  Created by binsnoel on 07/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeIDView: UIView!
    @IBOutlet weak var pokeID: Capsule!
    @IBOutlet weak var pokeTypeA: Capsule!
    @IBOutlet weak var pokeTypeB: Capsule!
    @IBOutlet weak var typeAWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pokeID.view.backgroundColor = UIColor.pkPokeIDColor
        pokeID.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(11)
        pokeImage.backgroundColor = UIColor.clear
    }
    
    func setTypeACapsule(_ type:Enums.PokemonType){
        pokeTypeA.capsuleLabel.text = type.rawValue.uppercased()
        pokeTypeA.capsuleLabel.textColor = UIColor.white
        pokeTypeA.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(10)
        pokeTypeA.view.backgroundColor = Common.getTypeColor(type)
        
    }
    
    func setTypeBCapsule(_ type:Enums.PokemonType){
        pokeTypeB.capsuleLabel.text = type.rawValue.uppercased()
        pokeTypeB.capsuleLabel.textColor = UIColor.white
        pokeTypeB.capsuleLabel.font = pokeTypeB.capsuleLabel.font.withSize(10)
        pokeTypeB.view.backgroundColor = Common.getTypeColor(type)
        
    }
    
    func checkTypes() {
        if(pokeTypeB.capsuleLabel.text == "NONE"){
            pokeTypeB.isHidden = true
            typeAWidth.constant = 140
        }
        else {
            pokeTypeB.isHidden = false
            typeAWidth.constant = 65
        }
    }

}
