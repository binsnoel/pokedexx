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
    
    var texts : [String] = ["Applying Repel", "Waking Snorlax", "Seeking Seaking", "Charging Pikachu" ,"Loading Pokédex"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerController.shared.getPokemonData()
        
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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            animationTypeLabel.text = "Feeding Snorlax"
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            animationTypeLabel.text = "Loading Pokédex"
        }
        
    }
    
//    func getPokemonData(){
//        
//        for id in 1...15 {
//            let uri = Constants.baseUri + Constants.pokemonUri + String(id)
//            
//            print("Sending request \(uri)")
//            Alamofire.request(uri).validate().responseJSON { response in
//                switch response.result {
//                case .success:
//                    print("Fetching data with success from \(uri)")
//                    if((response.result.value) != nil) {
//                        Parser().parsePokemonData(json: JSON(response.result.value!))
//                    }
//                case .failure(let error):
//                    let appearance = SCLAlertView.SCLAppearance(
//                        showCircularIcon: true
//                    )
//                    let alertView = SCLAlertView(appearance: appearance)
//                    let alertViewIcon = UIImage(named: "pokeball2") //Replace the IconImage text with the image name
//                    alertView.showInfo("Custom icon", subTitle: "error in request", circleIconImage: alertViewIcon)
//                    print(error)
//                }
//            }
//        }
//    }


}
