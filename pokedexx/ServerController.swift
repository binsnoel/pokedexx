//
//  ServerController.swift
//  pokedexx
//
//  Created by binsnoel on 09/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class ServerController {
    public static let shared = ServerController()
    let isFetching = false
    
    func fetchPokedex() {
//        if PokemonDao.shared.pokedexCache.count < 151 {
//            let uri = Constants.baseUri + Constants.pokedexUri + "2/"
//            
//            let size = CGSize(width: 30, height: 30)
//            startAnimating(size, message: "Loading Pokédex...", type: .ballTrianglePath)
//            
//            Alamofire.request(uri).validate().responseJSON { response in
//                switch response.result {
//                case .success:
//                    print("Fetching data with success from \(uri)")
//                    if((response.result.value) != nil) {
//                        self.parseJSONPokedex(json: JSON(response.result.value!))
//                        PokemonDao.shared.refreshCache()
//                        self.tableView.reloadData()
//                        DispatchQueue.main.async {
//                            self.stopAnimating()
//                        }
//                    }
//                case .failure(let error):
//                    print("Couldn't fetch data from \(uri)")
//                    print(error)
//                }
//            }
//        }
    }
    
    func getPokemonData(){
            for id in 1...15 {
                let uri = Constants.baseUri + Constants.pokemonUri + String(id)
                
                Alamofire.request(uri).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        print("Fetching data with success from \(uri)")
                        if((response.result.value) != nil) {
                            Parser().parsePokemonData(json: JSON(response.result.value!))
//                            PokemonDao.shared.refreshCache()
//                            self.tableView.reloadData()
//                            DispatchQueue.main.async {
//                                self.stopAnimating()
//                            }
                        }
                    case .failure(let error):
                        print("Couldn't fetch data from \(uri)")
                        print(error)
                    }
                }
            }
//        }
    }

    
}
