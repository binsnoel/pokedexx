//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

protocol EveelutionDelegate : class {
    func didTapPokemonEveelution(id: Int32)
}


@IBDesignable class Eveelution: UIView {
    
    @IBOutlet weak var chain9: EvolutionItem!
    @IBOutlet weak var chain8: EvolutionItem!
    @IBOutlet weak var chain7: EvolutionItem!
    @IBOutlet weak var chain6: EvolutionItem!
    @IBOutlet weak var chain5: EvolutionItem!
    @IBOutlet weak var chain4: EvolutionItem!
    @IBOutlet weak var chain3: EvolutionItem!
    @IBOutlet weak var chain2: EvolutionItem!
    @IBOutlet weak var chain1: EvolutionItem!
    @IBOutlet var view: UIView!
    @IBOutlet weak var innerView: UIView!
    var chainArr = [Pokemon]()
    weak var delegate:EveelutionDelegate?
    
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
        innerView.layer.cornerRadius = 9
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        //        // Gesture Recognizers
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain1.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain2.addGestureRecognizer(gesture2)
        
        let gesture3 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain3.addGestureRecognizer(gesture3)
        
        let gesture4 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain4.addGestureRecognizer(gesture4)
        
        let gesture5 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain5.addGestureRecognizer(gesture5)
        
        let gesture6 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain6.addGestureRecognizer(gesture6)
        
        let gesture7 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain7.addGestureRecognizer(gesture7)
        
        let gesture8 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain8.addGestureRecognizer(gesture8)
        
        let gesture9 = UITapGestureRecognizer(target: self, action:  #selector (self.tapped (_:)))
        self.chain9.addGestureRecognizer(gesture9)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setup(_ chain: [Pokemon], current: Pokemon) {
        var ch = chain //chain.sorted(by: { $0.id < $1.id })
        self.chainArr = ch
        
        if ch.count == 9 {
            self.chain1.setupItem(ch[0], current: current)
            self.chain2.setupItem(ch[1], current: current)
            self.chain3.setupItem(ch[2], current: current)
            self.chain4.setupItem(ch[3], current: current)
            self.chain5.setupItem(ch[4], current: current)
            self.chain6.setupItem(ch[5], current: current)
            self.chain7.setupItem(ch[6], current: current)
            self.chain8.setupItem(ch[7], current: current)
            self.chain9.setupItem(ch[8], current: current)
        }
        
    }
    
    func tapped(_ sender:UITapGestureRecognizer){
        let vw = sender.view as! EvolutionItem
        if vw.itemID != -1 { //tapped pokemon is not the current
            self.delegate?.didTapPokemonEveelution(id: vw.itemID)
        }
    }
    
}
