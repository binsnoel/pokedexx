//
//  ViewController.swift
//  pokedexx
//
//  Created by binsnoel on 02/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UICollectionViewController {
    
    let reuseIdentifier = "pokedexcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request()
    }
    
    func request() {
        var uri = Constants.baseUri + Constants.pokemonUri
        uri = uri + "1"
        print(uri)
        Alamofire.request(uri).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    // MARK: - UICollectionViewDataSource protocol
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 151
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PokemonCollectionCell
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        let pokeid = indexPath.item + 1
        
        cell.image.image = UIImage.init(named:String(pokeid))
        cell.pokeID.text = formatter.string(from:NSNumber(value:pokeid))
        cell.pokeName.text = "Bulbasaur"
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {    }
}

