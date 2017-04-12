//
//  PokedexTableViewController.swift
//  pokedexx
//
//  Created by binsnoel on 07/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

extension PokedexTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
//        code
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class PokedexTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokedex = [Int32: String]()
    var loading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokedex()
        initializeSearchBar()
    }
    
    func initializeSearchBar() {
        searchController.searchBar.placeholder = "Search for Pokémon"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredPokedex = arrayPokedex.filter { pokemon in
//            return pokemon[.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        tableView.reloadData()
//    }
    
    func fetchPokedex() {
        if PokemonDao.shared.pokedexCache.count < 151 {
            let uri = Constants.baseUri + Constants.pokedexUri + "2/"
            
            let size = CGSize(width: 30, height: 30)
            startAnimating(size, message: "Loading Pokédex...", type: .ballTrianglePath)
            
            Alamofire.request(uri).validate().responseJSON { response in
                switch response.result {
                case .success:
                    print("Fetching data with success from \(uri)")
                    if((response.result.value) != nil) {
                        self.parseJSONPokedex(json: JSON(response.result.value!))
                        PokemonDao.shared.refreshCache()
                        self.tableView.reloadData()
                        DispatchQueue.main.async {
                            self.stopAnimating()
                        }
                    }
                case .failure(let error):
                    print("Couldn't fetch data from \(uri)")
                    print(error)
                }
            }
        }
    }
    
    func parseJSONPokedex(json : JSON) {
        var jsonPokedex = [[String : AnyObject]]()
        print(json)
        if let resData = json["pokemon_entries"].arrayObject {
            jsonPokedex = resData as! [[String:AnyObject]]
            if jsonPokedex.count > 0 {
                for pokemon in jsonPokedex {
                    
                    if let pokeID = pokemon["entry_number"] as? Int32 {
                        if let pokeName = pokemon["pokemon_species"]?["name"] as? String {
                            print(pokeName + " Added to DB")
                            PokemonDao.shared.addPokemon(poke_ID: pokeID, poke_name: pokeName.capitalized)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonDao.shared.pokedexCache.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath) as! PokedexTableViewCell
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        cell.pokeID.capsuleLabel.text = "#" + formatter.string(from: (indexPath.row + 1) as NSNumber)!
        
        if let pkmnImage:UIImage = UIImage(named: "\(indexPath.row + 1).png") {
            cell.pokeImage.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            cell.pokeImage.image = unknownImage
        }
        
        cell.pokeName.text = PokemonDao.shared.pokedexCache[indexPath.row].poke_name!
//        cell.typeA = Enums.PokemonType.Grass
//        cell.typeB = Enums.PokemonType.unkown
        
        return cell
    }
    
}
