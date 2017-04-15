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
        
//        if let a = p.poke_typeA as String! {
////            cell.setTypeACapsule(Enums.PokemonType(rawValue: a)!)
//        }
//        if let b = p.poke_typeB as String! {
////            cell.setTypeBCapsule(Enums.PokemonType(rawValue: b)!)
//        }
//        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}
