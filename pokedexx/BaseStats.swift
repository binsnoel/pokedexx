//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class BaseStats: UIView {
    
    
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblSpDef: UILabel!
    @IBOutlet weak var lblSpAtk: UILabel!
    @IBOutlet weak var lblDef: UILabel!
    @IBOutlet weak var lblAtk: UILabel!
    @IBOutlet weak var lblHP: UILabel!
    @IBOutlet weak var Speed: UIView!
    @IBOutlet weak var SpDef: UIView!
    @IBOutlet weak var SpAtk: UIView!
    @IBOutlet weak var Def: UIView!
    @IBOutlet weak var Atk: UIView!
    @IBOutlet weak var HP: UIView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var maxSpDef: UILabel!
    @IBOutlet weak var maxSpAtk: UILabel!
    @IBOutlet weak var maxDef: UILabel!
    @IBOutlet weak var maxAtk: UILabel!
    @IBOutlet weak var maxHP: UILabel!
    @IBOutlet weak var minSpeed: UILabel!
    @IBOutlet weak var minSpDef: UILabel!
    @IBOutlet weak var minSpAtk: UILabel!
    @IBOutlet weak var minDef: UILabel!
    @IBOutlet weak var minAtk: UILabel!
    @IBOutlet weak var minHP: UILabel!
    @IBOutlet var view: UIView!
    
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
//        view.layer.cornerRadius = 10
//        innerView.layer.cornerRadius = 9
        
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
    
    func setupColor(pokemonType: Enums.PokemonType) {
        self.HP.backgroundColor = Common.getTypeColor(pokemonType)
        self.Atk.backgroundColor = Common.getTypeColor(pokemonType)
        self.Def.backgroundColor = Common.getTypeColor(pokemonType)
        self.SpAtk.backgroundColor = Common.getTypeColor(pokemonType)
        self.SpDef.backgroundColor = Common.getTypeColor(pokemonType)
        self.Speed.backgroundColor = Common.getTypeColor(pokemonType)
        
        if pokemonType == .Dark || pokemonType == .Fighting || pokemonType == .Ghost
            || pokemonType == .Poison{
            
            self.lblHP.textColor = UIColor.white
            self.lblAtk.textColor = UIColor.white
            self.lblDef.textColor = UIColor.white
            self.lblSpAtk.textColor = UIColor.white
            self.lblSpDef.textColor = UIColor.white
            self.lblSpeed.textColor = UIColor.white
        }
    }
    
    func setupWidths() {
        
//        self.HP.backgroundColor = Common.getTypeColor(pokemonType)
//        self.Atk.backgroundColor = Common.getTypeColor(pokemonType)
//        self.Def.backgroundColor = Common.getTypeColor(pokemonType)
//        self.SpAtk.backgroundColor = Common.getTypeColor(pokemonType)
//        self.SpDef.backgroundColor = Common.getTypeColor(pokemonType)
//        self.Speed.backgroundColor = Common.getTypeColor(pokemonType)
    }
    

}
