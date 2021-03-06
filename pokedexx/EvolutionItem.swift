//
//  EvolutionItem.swift
//  pokedexx
//
//  Created by binsnoel on 04/05/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

@IBDesignable class EvolutionItem: UIView {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var capsuleID: Capsule!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var view: UIView!
    var isSelected = false
    var itemID : Int32 = 0
    
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
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        if isSelected {
            self.view.backgroundColor = UIColor.lightGray
        }
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setupItem(_ item: Pokemon, current: Pokemon) {
        self.itemID = item.id
        
        self.capsuleID.capsuleLabel.text = Common.format(forId: item.speciesID)
        self.capsuleID.setCapsuleView(type: Enums.CapsuleType.ID)
        if let pkmnImage:UIImage = UIImage(named: "\(item.id).png") {
            self.image.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            self.image.image = unknownImage
        }
        
        self.lblName.text = Common.formatName(item.name!)
        
        if item == current {
            self.itemID = -1
            self.view.layer.cornerRadius = 5
            self.view.layer.borderWidth = 1
            self.view.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}
