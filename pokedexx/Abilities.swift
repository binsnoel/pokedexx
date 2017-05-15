//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class Abilities: UIView {
    
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var ability1: Capsule!
    @IBOutlet weak var ability2: Capsule!
    @IBOutlet weak var ability3: Capsule!
    
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var ability1Width: NSLayoutConstraint!
    
    @IBOutlet weak var ability1Height: NSLayoutConstraint!
    @IBOutlet weak var ability1Top: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        //setup view
        self.outerView.backgroundColor = UIColor.darkGray
        self.outerView.layer.cornerRadius = 10
        self.innerView.layer.cornerRadius = 9
        self.innerView.backgroundColor = UIColor.white
       
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func initializeView(withAbilities: [PokemonAbilities]) {
        
        //call hiding/showing ability capsules depneding on count
        
        if withAbilities.count == 2 {
            self.lblOr.isHidden = true
            self.ability2.isHidden = true
            print(self.ability3.frame.width)
            self.ability1Width.constant = self.ability3.frame.width - 16
        }
        else if withAbilities.count == 1 {
            self.lblOr.isHidden = true
            self.ability2.isHidden = true
            print(self.ability3.frame.width)
            self.ability1Width.constant = self.ability3.frame.width
            self.ability3.isHidden = true
            self.ability1Top.constant = 20
//            self.ability1Height.constant = 50 //doesnt work
        }
        
        for ability in withAbilities {
            
            switch ability.slot {
                case 1:
                    self.ability1.setCapsuleAbilityView(type: .Ability, ability: ability.desc!)
                    break
                case 2:
                    self.ability2.setCapsuleAbilityView(type: .Ability, ability: ability.desc!)
                    break
                case 3:
                    self.ability3.setCapsuleAbilityView(type: .AbilityHidden, ability: ability.desc!)
                    break
                default:
                    break
            }
        }
    }
    
    
}








