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
        
        pokeID.setCapsuleView(type: Enums.CapsuleType.ID)
        pokeImage.backgroundColor = UIColor.clear
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
