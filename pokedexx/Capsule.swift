//
//  Capsule.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class Capsule: UIView {
    // Our custom view from the XIB file
    var view: UIView!
    
    @IBOutlet weak var capsuleLabel: UILabel!
    
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
        switch type {
        case .ID:
            self.view.backgroundColor = UIColor.pkPokeIDColor
            self.capsuleLabel.font = self.capsuleLabel.font.withSize(11)
            break
        case .PokeType:
                self.capsuleLabel.textColor = UIColor.white
                self.capsuleLabel.font = self.capsuleLabel.font.withSize(10)
                self.capsuleLabel.text = pokemonType.desc.uppercased()
                self.view.backgroundColor = Common.getTypeColor(pokemonType)
            break
        case .Species:
            self.capsuleLabel.textColor = UIColor.black
            self.capsuleLabel.font = self.capsuleLabel.font.withSize(10)
            self.view.backgroundColor = UIColor.white
            self.view.layer.borderWidth = 1
            self.view.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
}
