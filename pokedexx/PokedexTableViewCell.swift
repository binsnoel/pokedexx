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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pokeID.view.backgroundColor = UIColor.pkPokeIDColor
        pokeID.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(11)
        
        pokeTypeA.capsuleLabel.text = "GRASS"
        pokeTypeA.capsuleLabel.textColor = UIColor.white
        pokeTypeA.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(10)
        pokeTypeA.view.backgroundColor   = UIColor.pkGrassColor
        
        
        pokeTypeB.capsuleLabel.text = "NORMAL"
        pokeTypeB.capsuleLabel.textColor = UIColor.white
        pokeTypeB.capsuleLabel.font = pokeTypeB.capsuleLabel.font.withSize(10)
        pokeTypeB.view.backgroundColor   = UIColor.pkNormalColor
    }

}
