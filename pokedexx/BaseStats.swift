//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class BaseStats: UIView {
    
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var statViewWidth: NSLayoutConstraint!
    @IBOutlet weak var speedWidth: NSLayoutConstraint!
    @IBOutlet weak var spDefWidth: NSLayoutConstraint!
    @IBOutlet weak var spAtkWidth: NSLayoutConstraint!
    @IBOutlet weak var defWidth: NSLayoutConstraint!
    @IBOutlet weak var atkWidth: NSLayoutConstraint!
    @IBOutlet weak var hpWidth: NSLayoutConstraint!
    @IBOutlet weak var statview: UIView!
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
        self.view.backgroundColor = UIColor.darkGray
        self.view.layer.cornerRadius = 10
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
    
    func setup(_ pokeStats: PokemonStats) {
        self.lblHP.text = String(pokeStats.hp)
        self.lblAtk.text = String(pokeStats.atk)
        self.lblDef.text = String(pokeStats.def)
        self.lblSpAtk.text = String(pokeStats.spAtk)
        self.lblSpDef.text = String(pokeStats.spDef)
        self.lblSpeed.text = String(pokeStats.speed)
        self.calculateTotal(pokeStats)
        
        self.hpWidth.constant = calculateWidth(pokeStats.hp)
        self.atkWidth.constant = calculateWidth(pokeStats.atk)
        self.defWidth.constant = calculateWidth(pokeStats.def)
        self.spAtkWidth.constant = calculateWidth(pokeStats.spAtk)
        self.spDefWidth.constant = calculateWidth(pokeStats.spDef)
        self.speedWidth.constant = calculateWidth(pokeStats.speed)
    }
    
    func calculateWidth(_ stat: Int32) -> CGFloat{
        let w = self.statview.bounds.width
        let progress = CGFloat(stat)
        var x = w * (progress/255)
        x = x < 28 ? 28 : x
        return x
    }
    
    func calculateTotal(_ stat: PokemonStats) {
        let total = stat.hp +
                    stat.atk +
                    stat.def +
                    stat.spAtk +
                    stat.spDef +
                    stat.speed
        self.total.text = String(total)
    }
    
    
    

}
