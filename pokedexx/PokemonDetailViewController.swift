//
//  PokemonDetailViewController.swift
//  pokedexx
//
//  Created by binsnoel on 08/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeEntry: UITextView!
    
    @IBOutlet weak var capsuleID: Capsule!
    @IBOutlet weak var capsuleSpecies: Capsule!
    @IBOutlet weak var capsuleTypeB: Capsule!
    @IBOutlet weak var capsuleTypeA: Capsule!
    @IBOutlet weak var lblCapsuleTypeB: UILabel!
    @IBOutlet weak var lblCapsuleTypeA: UILabel!
    
    @IBOutlet weak var abilitiesView: Abilities!
    
    @IBOutlet weak var lblCapsuleTypeATrail: NSLayoutConstraint!
    @IBOutlet weak var capsuleTpyeATrail: NSLayoutConstraint!
    @IBOutlet weak var lblCapsuleTypeAWidth: NSLayoutConstraint!
    @IBOutlet weak var capsuleTypeAWidth: NSLayoutConstraint!
    
    var selectedPokeID : Int32 = 0
//    var hasLoadedDetails = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let scrollSize = CGSize(width: myView.frame.width,height: myView.frame.height)
        scrollView.contentSize = scrollSize
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentSize = self.pokeEntry.sizeThatFits(self.pokeEntry.bounds.size)
        var frame = self.pokeEntry.frame
        frame.size.height = contentSize.height
        self.pokeEntry.frame = frame
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.pokeEntry, attribute: .height, relatedBy: .equal, toItem: self.pokeEntry, attribute: .width, multiplier: self.pokeEntry.bounds.height/self.pokeEntry.bounds.width, constant: 1)
        self.pokeEntry.addConstraint(aspectRatioTextViewConstraint)
    }
    
    // MARK: - View setup functions
    
    func getDetails(currentPokemon: Pokemon) {
        
        let deets = currentPokemon.getDetails()
        if deets != nil {
            self.pokeEntry.text = deets?.desc!.condensedWhitespace
            
            //setup evolution
            
            self.evolutionView.setup(currentPokemon.getEvolutionChain(chainID: (deets?.evolution_chain)!))
            
        }
        
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
                
                //setup Abilities View - Pass the Primary Type of pokemon
                setupAbilitiesView(typeA: Enums.PokemonType(rawValue: a)!)
            }
            if let b = Int(poke.typeB!){
                capsuleTypeB.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: b)!)
            }
            
            capsuleSpecies.setCapsuleView(type: Enums.CapsuleType.Species)
            capsuleSpecies.capsuleLabel.text = poke.genus! + " Pokémon"
            
            self.pokeHeight.text = self.convertHeight(poke.height)
            self.pokeWeight.text = self.convertWeight(poke.weight)
            
            self.checkTypes()
            
            getDetails(currentPokemon: poke)
            
        }
    }
    
    func setupAbilitiesView(typeA: Enums.PokemonType) {
        let selectedPokeAbilities = PokemonDao.shared.pokemonAbilities.filter { pk in
            return (pk.poke_id == selectedPokeID)
        }
        
        self.abilitiesView.initializeView(withAbilities: selectedPokeAbilities, pokemonType: typeA )
    }
    
    // MARK: - Helper functions
    
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
