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
    @IBOutlet weak var pokeTypeATrailing: NSLayoutConstraint!
    @IBOutlet weak var pokeIDView: UIView!
    @IBOutlet weak var pokeID: Capsule!
    @IBOutlet weak var pokeTypeA: Capsule!
    @IBOutlet weak var pokeTypeB: Capsule!
    @IBOutlet weak var pokeTypeBWidth: NSLayoutConstraint!
    @IBOutlet weak var pokeTypeAWidth: NSLayoutConstraint!
    @IBOutlet weak var imagBgView: UIView!
    var typeA = Enums.PokemonType.Ghost
    var typeB = Enums.PokemonType.Fire
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.pkPokeIDColor
        pokeID.view.backgroundColor = UIColor.pkPokeIDColor
        imagBgView.backgroundColor = UIColor.pkPokeIDColor
        pokeID.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(11)
        
        pokeTypeA.capsuleLabel.text = typeA.rawValue.uppercased()
        pokeTypeA.capsuleLabel.textColor = UIColor.white
        pokeTypeA.capsuleLabel.font = pokeTypeA.capsuleLabel.font.withSize(10)
        pokeTypeA.view.backgroundColor   = Common.getTypeColor(typeA)
        
        pokeTypeB.capsuleLabel.text = typeB.rawValue.uppercased()
        pokeTypeB.capsuleLabel.textColor = UIColor.white
        pokeTypeB.capsuleLabel.font = pokeTypeB.capsuleLabel.font.withSize(10)
        pokeTypeB.view.backgroundColor   = Common.getTypeColor(typeB)
        
        pokeImage.layer.cornerRadius = pokeImage.frame.size.width / 2;
        pokeImage.clipsToBounds = true;
        pokeImage.backgroundColor = UIColor.pkPokeIDColor
        checkTypes()
    }
    
    func checkTypes() {
        if(typeB == Enums.PokemonType.None){
            pokeTypeB.isHidden = true
            
//            pokeTypeAWidth.constant = 115
//            pokeTypeATrailing.constant = -60
        }
        else {
            pokeTypeB.isHidden = false
//            pokeTypeAWidth.constant = 55
//            pokeTypeBWidth.constant = 55
        }
    }

}
