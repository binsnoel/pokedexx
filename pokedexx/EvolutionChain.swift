//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
protocol EvolutionChainDelegate : class {
    func didTapPokemon(id: Int32)
}

@IBDesignable class EvolutionChain: UIView {
    
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet var view: UIView!
    @IBOutlet weak var chain3: EvolutionItem!
    @IBOutlet weak var chain2: EvolutionItem!
    @IBOutlet weak var chain1: EvolutionItem!
    var chainArr = [Pokemon]()
    weak var delegate:EvolutionChainDelegate?
    
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

        if ch.count == 3 {
            self.chain1.setupItem(ch[0], current: current)
            self.chain2.setupItem(ch[1], current: current)
            self.chain3.setupItem(ch[2], current: current)
        }
    }
    
    func tapped(_ sender:UITapGestureRecognizer){
        let vw = sender.view as! EvolutionItem
        if vw.itemID != -1 { //tapped pokemon is not the current
            self.delegate?.didTapPokemon(id: vw.itemID)
        }
    }
    
}
