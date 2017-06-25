//
//  PokemonDetailViewController.swift
//  pokedexx
//
//  Created by binsnoel on 08/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var fiveBranchView: FiveBranchEvolution!
    @IBOutlet weak var eveelution: Eveelution!
    @IBOutlet weak var threeBranchEvolution: ThreeBranchEvolution!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var branchEvolutionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var evolutionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var branchEvolutionChain: BranchEvolutionChain!
    @IBOutlet weak var innverViewScrool: UIView!
    @IBOutlet weak var megaEvolution: EvolutionChain!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var baseStatsView: BaseStats!
    @IBOutlet weak var headerView: UIView!
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
    @IBOutlet weak var evolutionView: EvolutionChain!
    @IBOutlet weak var lblCapsuleTypeATrail: NSLayoutConstraint!
    @IBOutlet weak var capsuleTpyeATrail: NSLayoutConstraint!
    @IBOutlet weak var lblCapsuleTypeAWidth: NSLayoutConstraint!
    @IBOutlet weak var capsuleTypeAWidth: NSLayoutConstraint!
    
    var selectedPokeID : Int32 = 0
    var heightReduction : Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
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
    
    //get details of pokemon - specifically evolution details
    func getDetails(currentPokemon: Pokemon) {
        
        //one then 2 branch evolution
        let slowpokeArr = [79,80,199,361,362,478,366,367,368,412,413,414,290,292,291]
        //two then 2 brannch evolution
        let gloomArr = [43,44,45,182,60,61,62,186,280,281,282,475]
        //one then 3 branch evolution
        let tyrogueArr = [236,237,106,107]
        
        let deets = currentPokemon.getDetails()
        if deets != nil {
            //setup evolution
            let x = currentPokemon.getEvolutionChain(chainID: (deets?.evolution_chain)!)!
            let id = currentPokemon.speciesID
            
            let views = self.stackView.arrangedSubviews
            for viewx in views {
                self.stackView.removeArrangedSubview(viewx)
                viewx.isHidden = true
            }
            
            if x.count <= 3 {
                if slowpokeArr.contains(Int(id)) {
                    self.branchEvolutionChain.delegate = self
                    self.branchEvolutionChain.setup(x, current: currentPokemon)
                    self.branchEvolutionChain.isHidden = false
                    self.stackView.addArrangedSubview(self.branchEvolutionChain)
                }
                else { // normal evolution
                    self.evolutionView.delegate = self
                    self.evolutionView.setup(x, current: currentPokemon)
                    self.evolutionView.isHidden = false
                    self.stackView.addArrangedSubview(self.evolutionView)
                }
            }
            else if x.count == 4 {
                if gloomArr.contains(Int(id)) {
                    self.branchEvolutionChain.delegate = self
                    self.branchEvolutionChain.setup(x, current: currentPokemon)
                    self.branchEvolutionChain.isHidden = false
                    self.stackView.addArrangedSubview(self.branchEvolutionChain)
                }
                else if tyrogueArr.contains(Int(id)){
                    self.threeBranchEvolution.delegate = self
                    self.threeBranchEvolution.setup(x, current: currentPokemon)
                    self.threeBranchEvolution.isHidden = false
                    self.stackView.addArrangedSubview(self.threeBranchEvolution)
                }
            }
            else if x.count == 5 {
                self.fiveBranchView.delegate = self
                self.fiveBranchView.setup(x, current: currentPokemon)
                self.fiveBranchView.isHidden = false
                self.stackView.addArrangedSubview(self.fiveBranchView)
            }
            else if x.count > 5 {
                self.eveelution.delegate = self
                self.eveelution.setup(x, current: currentPokemon)
                self.eveelution.isHidden = false
                self.stackView.addArrangedSubview(self.eveelution)
            }
            
            self.pokeEntry.text = currentPokemon.getPokeEntry().condensedWhitespace
            if let s = currentPokemon.getPokeStats(){
                self.baseStatsView.setup(s)
            }
        }
        
        if currentPokemon.switchable == 0 {
            heightReduction += 0
        }
        else{

            heightReduction += 200
            
            if currentPokemon.switchable == -1 {
                Parser.shared.parsePokemonMegaEvolution(speciesID: currentPokemon.speciesID)
            }
            if currentPokemon.switchable == 0 {
//                heightReduction += 0
                self.stackView.removeArrangedSubview(self.megaEvolution)
                self.megaEvolution.isHidden = true
            }
            self.megaEvolution.delegate = self
            self.megaEvolution.isHidden = false
            self.stackView.addArrangedSubview(self.megaEvolution)
            self.megaEvolution.setupMegaEvolution(currentPokemon.getMegaEvolutionChain()!, currentPokemon)
        }
    }
    
    //setup the view for pokemon name, image, type, weight, height
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
                capsuleTypeA.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: a)!)
                
                //setup Abilities View - Pass the Primary Type of pokemon
                setupAbilitiesView(typeA: Enums.PokemonType(rawValue: a)!)
                
                //setup BaseStats Colors
                self.baseStatsView.setupColor(pokemonType: Enums.PokemonType(rawValue: a)!)
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
        var fs = String(feet)
//        fs = String(fs.substring(to: fs.index(before: fs.endIndex)))
        let feetIn = fs.replacingOccurrences(of: ".", with: "'") + "\""
        return "\(feetIn) (" + String(meter) + " m)"
    }
    
    func convertWeight(_ weight: Int32) -> String{
        let kg = Double(weight) * 0.1
        let lbs = Double(round(100*(kg * 2.20))/100)
        return "\(lbs) lbs (" + String(kg) + " kg)"
    }
}


extension PokemonDetailViewController : EvolutionChainDelegate {
    func didTapPokemon(id: Int32) {
        print("tapped id \(id)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        nextViewController.selectedPokeID = id
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}


extension PokemonDetailViewController : BranchEvolutionChainDelegate {
    func didTapPokemonBranch(id: Int32) {
        print("tapped id \(id)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        nextViewController.selectedPokeID = id
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}



extension PokemonDetailViewController : ThreeBranchEvolutionChainDelegate {
    func didTapPokemonThreeBranch(id: Int32) {
        print("tapped id \(id)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        nextViewController.selectedPokeID = id
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension PokemonDetailViewController : EveelutionDelegate {
    func didTapPokemonEveelution(id: Int32) {
        print("tapped id \(id)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        nextViewController.selectedPokeID = id
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension PokemonDetailViewController : FiveBranchEvolutionChainDelegate {
    func didTapPokemonFiveBranch(id: Int32) {
        print("tapped id \(id)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        nextViewController.selectedPokeID = id
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
