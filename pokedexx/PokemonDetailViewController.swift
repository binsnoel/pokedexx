//
//  PokemonDetailViewController.swift
//  pokedexx
//
//  Created by binsnoel on 08/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var inside: UIView!
    @IBOutlet weak var abilityView: UIView!
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
    
    @IBOutlet weak var lblCapsuleTypeATrail: NSLayoutConstraint!
    @IBOutlet weak var capsuleTpyeATrail: NSLayoutConstraint!
    @IBOutlet weak var lblCapsuleTypeAWidth: NSLayoutConstraint!
    @IBOutlet weak var capsuleTypeAWidth: NSLayoutConstraint!
    var selectedPokeID : Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == selectedPokeID }) {
            let detail = PokemonDao.shared.pokeDetailCache[index2]
            
            self.pokeEntry.text = detail.desc!.condensedWhitespace
        }
        else {
            Parser().parsePokemonDetail(byID: selectedPokeID)
        }
        
        setupView()
        
    }
    
    func setupView() {
        if let index = PokemonDao.shared.pokedexCache.index(where: { $0.id == selectedPokeID }) {
            let poke = PokemonDao.shared.pokedexCache[index]
            
            self.capsuleID.capsuleLabel.text = Common.format(forId: poke.speciesID)
            
            if let pkmnImage:UIImage = UIImage(named: "\(poke.id).png") {
                self.pokeImage.image = pkmnImage
            } else if let unknownImage:UIImage = UIImage(named:"0.png") {
                self.pokeImage.image = unknownImage
            }
            
            self.pokeName.text = Common.formatName(poke.name!)
            self.pokeName.baselineAdjustment = .alignCenters
            
            capsuleID.setCapsuleView(type: Enums.CapsuleType.ID)
            
            if let a = Int(poke.typeA!){
                print(Enums.PokemonType(rawValue: a)!)
                capsuleTypeA.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: a)!)
            }
            if let b = Int(poke.typeB!){
                capsuleTypeB.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: b)!)
            }
            
            capsuleSpecies.setCapsuleView(type: Enums.CapsuleType.Species)
            capsuleSpecies.capsuleLabel.text = poke.genus! + " Pokémon"
            
            self.pokeHeight.text = self.convertHeight(poke.height)
            self.pokeWeight.text = self.convertWeight(poke.weight)
            
            self.checkTypes()
            
            if let index2 = PokemonDao.shared.pokeDetailCache.index(where: { $0.speciesID == selectedPokeID }) {
                let detail = PokemonDao.shared.pokeDetailCache[index2]
                
                self.pokeEntry.text = detail.desc!.condensedWhitespace
            }
            
            self.abilityView.backgroundColor = UIColor.darkGray
            self.abilityView.layer.cornerRadius = 10
            self.inside.layer.cornerRadius = 9
        }
    }
    
    func checkTypes() {
        
        if(capsuleTypeB.capsuleLabel.text == "NONE"){
            capsuleTypeB.isHidden = true
            lblCapsuleTypeB.isHidden = true
            
            capsuleTypeAWidth.constant = 134
            lblCapsuleTypeAWidth.constant = 134
            lblCapsuleTypeATrail.constant = 0
            capsuleTpyeATrail.constant = 0
            lblCapsuleTypeA.text = "Type"
        }
        else {
            capsuleTypeB.isHidden = false
            lblCapsuleTypeB.isHidden = false
            
            capsuleTypeAWidth.constant = 65
            lblCapsuleTypeAWidth.constant = 65
            lblCapsuleTypeA.text = "Primary"
        }
    }
    
    func convertHeight(_ height: Int32) -> String{
        let meter = Double(height) * 0.1
        let feet = Double(round(100*(meter * 3.2808))/100)
        let feetIn = String(feet).replacingOccurrences(of: ".", with: "'") + "\""
        return "\(feetIn) (" + String(meter) + " m)"
    }
    
    func convertWeight(_ weight: Int32) -> String{
        let kg = Double(weight) * 0.1
        let lbs = Double(round(100*(kg * 2.20))/100)
        return "\(lbs) lbs (" + String(kg) + " kg)"
    }
}
