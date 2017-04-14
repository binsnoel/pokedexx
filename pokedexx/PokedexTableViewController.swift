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
//        fetchPokedex()
        
//        ServerController.shared.getPokemonData()
        
        getPokemonData()
        initializeSearchBar()
    }
    
    func getPokemonData(){
        
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: "Loading Pokédex...", type: .ballTrianglePath)
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
                        self.tableView.reloadData()
                        
                    }
                case .failure(let error):
                    print("Couldn't fetch data from \(uri)")
                    print(error)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.stopAnimating()
        }
        //        }
    }
    
    func parsePokemonData(json: JSON) {
        var typeA = ""
        var typeB = ""
        
        if let name = json["name"].string {
            //print(name)
            if let id = json["id"].number {
                //print(id)
                if let type1 = json["types"][1]["type"]["name"].string{
                    typeA = type1
                }
                if let type2 = json["types"][0]["type"]["name"].string{
                    if typeA != "" {
                        typeB = type2
                    }
                    else {
                        typeA = type2
                    }
                }
                //print(typeA)
                //print(typeB)
                PokemonDao.shared.addPokemon(poke_ID: Int32(id),
                                             poke_name: name.capitalized,
                                             poke_typeA: typeA.capitalized,
                                             poke_typeB: typeB.capitalized)
                
                PokemonDao.shared.refreshCache()
            }
        }
        
        
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
        cell.pokeID.capsuleLabel.text = "#" + formatter.string(from: PokemonDao.shared.pokedexCache[indexPath.row].poke_id as NSNumber)!
        
        if let pkmnImage:UIImage = UIImage(named: "\(indexPath.row + 1).png") {
            cell.pokeImage.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            cell.pokeImage.image = unknownImage
        }
        
        cell.pokeName.text = PokemonDao.shared.pokedexCache[indexPath.row].poke_name!
        if let a = PokemonDao.shared.pokedexCache[indexPath.row].poke_typeA as String! {
            cell.setTypeACapsule(Enums.PokemonType(rawValue: a)!)
        }
        if let b = PokemonDao.shared.pokedexCache[indexPath.row].poke_typeB as String! {
            cell.setTypeBCapsule(Enums.PokemonType(rawValue: b)!)
        }
        cell.checkTypes()
        return cell
    }
    
    
}
