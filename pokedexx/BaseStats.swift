//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class BaseStats: UIView {
    
    
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
    

}
