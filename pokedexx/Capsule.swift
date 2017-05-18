//
//  Capsule.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class Capsule: UIView {
    
    var view: UIView!
    @IBOutlet weak var capsuleLabel: UILabel!
    @IBOutlet weak var info: UIImageView!
    @IBOutlet weak var lblHidden: UILabel!
    
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
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.lightGray

        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        //rounded left side of "hidden" label
        let path = UIBezierPath(roundedRect:self.lblHidden.bounds,
                                byRoundingCorners:[.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 5, height:  5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.lblHidden.layer.mask = maskLayer
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setCapsuleView(type: Enums.CapsuleType, pokemonType: Enums.PokemonType = Enums.PokemonType.None) {
        
        self.capsuleLabel.font = self.capsuleLabel.font.withSize(10)
        self.lblHidden.isHidden = true
        self.view.backgroundColor = UIColor.white
        
        switch type {
        case .ID:
            self.view.backgroundColor = UIColor.pkPokeIDColor
            self.capsuleLabel.font = self.capsuleLabel.font.withSize(11)
            break
        case .PokeType:
            self.capsuleLabel.textColor = UIColor.white
            self.capsuleLabel.text = pokemonType.desc.uppercased()
            self.view.backgroundColor = Common.getTypeColor(pokemonType)
            break
        case .Species:
            self.capsuleLabel.textColor = UIColor.black
            self.view.layer.borderWidth = 1
            self.view.layer.borderColor = UIColor.darkGray.cgColor
            break
        default:
            break
        }
    }
    
    func setCapsuleAbilityView(type: Enums.CapsuleType, ability: String, pokemonType: Enums.PokemonType) {
        self.capsuleLabel.font = self.capsuleLabel.font.withSize(10)
        self.lblHidden.isHidden = true
        self.info.isHidden = false
        self.view.backgroundColor = UIColor.white
        self.capsuleLabel.text = Common.formatName(ability)
        
        switch type {
            case .Ability:
                self.capsuleLabel.textColor = UIColor.black
                self.setAbilityCapsuleTextColor(pokemonType: pokemonType)
                self.view.layer.borderWidth = 1
                self.view.layer.borderColor = Common.getTypeColor(pokemonType).cgColor
                view.layer.cornerRadius = 5
                self.view.backgroundColor = Common.getTypeColor(pokemonType)
                break
            case .AbilityHidden:
                
                self.capsuleLabel.textColor = UIColor.black
                self.view.layer.borderWidth = 1
                self.view.layer.borderColor = Common.getTypeColor(pokemonType).cgColor
                view.layer.cornerRadius = 5
                self.lblHidden.isHidden = false
                self.lblHidden.backgroundColor = Common.getTypeColor(pokemonType)
                self.lblHidden.textColor = UIColor.black
                self.lblHidden.layer.borderWidth = 1
                self.lblHidden.layer.borderColor = Common.getTypeColor(pokemonType).cgColor
                break
            default:
                break
        }

    }
    
    func setAbilityCapsuleTextColor(pokemonType: Enums.PokemonType){
        if pokemonType == .Dark || pokemonType == .Fighting || pokemonType == .Ghost
         || pokemonType == .Poison{
            self.capsuleLabel.textColor = UIColor.white
        }
    }
}
