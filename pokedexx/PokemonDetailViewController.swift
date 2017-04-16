//
//  PokemonDetailViewController.swift
//  pokedexx
//
//  Created by binsnoel on 08/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var capsuleID: Capsule!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeEntry: UITextView!
    @IBOutlet weak var capsuleSpecies: Capsule!
    @IBOutlet weak var capsuleTypeB: Capsule!
    @IBOutlet weak var capsuleTypeA: Capsule!
    @IBOutlet weak var lblCapsuleTypeB: UILabel!
    @IBOutlet weak var lblCapsuleTypeA: UILabel!
    
    @IBOutlet weak var lblCapsuleTypeAWidth: NSLayoutConstraint!
    @IBOutlet weak var capsuleTypeAWidth: NSLayoutConstraint!
    var pokeID : Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let poke = PokemonDao.shared.pokedexCache[Int(pokeID-1)]
    
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        self.capsuleID.capsuleLabel.text = "#" + formatter.string(from: NSNumber(value:(poke.poke_id)))!
        
        if let pkmnImage:UIImage = UIImage(named: "\(poke.poke_id).png") {
            self.pokeImage.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            self.pokeImage.image = unknownImage
        }
        
        self.pokeName.text = poke.poke_name!
        
        capsuleID.setCapsuleView(type: Enums.CapsuleType.ID)
        
        if let a = poke.poke_typeA as String! {
            capsuleTypeA.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: a)!)
        }
        if let b = poke.poke_typeB as String! {
            capsuleTypeB.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: b)!)
        }
        
        self.checkTypes()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func checkTypes() {
        
        if(capsuleTypeB.capsuleLabel.text == "NONE"){
            capsuleTypeB.isHidden = true
            lblCapsuleTypeB.isHidden = true
            
            capsuleTypeAWidth.constant = 164
            lblCapsuleTypeAWidth.constant = 164
            lblCapsuleTypeA.text = "Type"
        }
        else {
            capsuleTypeB.isHidden = false
            lblCapsuleTypeB.isHidden = false
            
            capsuleTypeAWidth.constant = 80
            lblCapsuleTypeAWidth.constant = 80
            lblCapsuleTypeA.text = "Primary"
        }
    }

}
