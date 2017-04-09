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

class PokedexTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var jsonPokedex = [[String : AnyObject]]()
    var arrayPokedex = [Int32 : String]()
    var filteredPokedex = [Int32: String]()
    var loading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeActivityIndicator()
        fetchPokedex()
        initializeSearchBar()
    }
    
    func initializeActivityIndicator() {
        self.loading = NVActivityIndicatorView(frame:CGRect(x:0, y:0, width: 100, height: 100))
        self.loading.type = .ballClipRotatePulse
        self.loading.startAnimating()
        print(self.loading.isAnimating)
    }
    
    func initializeSearchBar() {
        searchController.searchBar.placeholder = "Search for Pokemon"
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
        
//        var activityIndicator = GTMActivityIndicatorView(frame: CGRect(X: 0, y: 0, width: 100, height:100))
//        activityIndicator.startAnimating()
        
        let uri = Constants.baseUri + Constants.pokedexUri + "2/"
        print(uri)
        Alamofire.request(uri).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Fetching data with success from \(uri)")
                if((response.result.value) != nil) {
                    self.parseJSONPokedex(json: JSON(response.result.value!))
                    self.tableView.reloadData()
                    self.loading.stopAnimating()
                }
            case .failure(let error):
                print("Could't fetch data from \(uri)")
                print(error)
            }
        }
    }
    
    func parseJSONPokedex(json : JSON) {
        if let resData = json["pokemon_entries"].arrayObject {
            self.jsonPokedex = resData as! [[String:AnyObject]]
            print(self.jsonPokedex)
            
            if self.jsonPokedex.count > 0 {
                for pokemon in self.jsonPokedex {
                    
                    if let pokeID = pokemon["entry_number"] as? Int32 {
                        if let pokeName = pokemon["pokemon_species"]?["name"] as? String {
                            PokemonDao.shared.upsertOne(entryNumber: pokeID, name: pokeName.capitalized)
//                            arrayPokedex[pokeID] = pokeName
                        }
                    }
                }
            }
        }
        
        print("ArrayPokedex: \(arrayPokedex)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayPokedex.count
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
        
        cell.pokeName.text = arrayPokedex[indexPath.row + 1]?.capitalized
        
        return cell
    }
    
}
