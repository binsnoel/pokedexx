//
//  ViewController.swift
//  pokedexx
//
//  Created by binsnoel on 02/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    
    let reuseIdentifier = "pokedexcell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PokemonCollectionCell
        
//        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.image.image = UIImage.init(named: items[indexPath.item])
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}

