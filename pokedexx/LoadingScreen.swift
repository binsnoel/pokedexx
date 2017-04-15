//
//  LoadingScreen.swift
//  pokedexx
//
//  Created by binsnoel on 14/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire
import SwiftyJSON
import SCLAlertView

class LoadingScreen: UIViewController,NVActivityIndicatorViewable {
    
    var texts = ["Applying Repel", "Waking Snorlax", "Seeking Seaking", "Charging Pikachu", "Hatching Eggs" ,"Loading Pokédex"]
    var timer : Timer?
    let initialNumberofPokemons = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        ServerController.shared.delegate = nil
    }
    
    func router(){
        if PokemonDao.shared.pokedexCache.count >= initialNumberofPokemons {
            displayPokedexView(animated:false)
        }
        else {
            queryPokemon()
        }
    }
    
    func queryPokemon(){
        ServerController.shared.delegate = self
        ServerController.shared.getPokemonDataById(from:1, to:Int32(initialNumberofPokemons))
        
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.darkGray
        
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x:0, y:0,width: 60, height: 60),
                                                            type: NVActivityIndicatorType.ballPulseSync)
        
        let animationTypeLabel = UILabel(frame: CGRect(x:0, y:0,width: 20, height: 20))
        activityIndicatorView.center = self.view.center
        activityIndicatorView.frame.origin.x += 5
        activityIndicatorView.frame.origin.y += 20
        
        animationTypeLabel.text = "Applying Super Repel"
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.black
        animationTypeLabel.center = self.view.center
        animationTypeLabel.textAlignment = .center
        animationTypeLabel.frame.origin.y += 40
        animationTypeLabel.font = UIFont(name: "System-Thin", size: 10.0)
        
        activityIndicatorView.padding = 20
        self.view.addSubview(activityIndicatorView)
        self.view.addSubview(animationTypeLabel)
        activityIndicatorView.startAnimating()
        
        var counter = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {_ in
            DispatchQueue.main.async(execute: {
                if counter < self.texts.count {
                    print(self.texts[counter])
                    animationTypeLabel.text = self.texts[counter]
                    counter += 1
                }
            })
        }
        self.timer?.fire()
    }
    
    func displayPokedexView(animated: Bool){
        self.timer?.invalidate()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PokedexView") as! PokedexTableViewController
        self.navigationController?.pushViewController(nextViewController, animated: animated)
    }

}

extension LoadingScreen: ServerControllerDelegate {
    
    func didFinishTask(sender: ServerController) {
        self.displayPokedexView(animated:true)
    }
    
    func didFinishSingleTask(sender: ServerController) {
        //do nothing
    }
}
