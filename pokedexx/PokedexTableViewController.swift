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
import SCLAlertView


extension PokedexTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        // code
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension PokedexTableViewController: ServerControllerDelegate {
    func didFinishTask(sender: ServerController) {
        // do stuff like updating the UI
    }
}

class PokedexTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokedex = [Int32: String]()
    var loading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appearance = SCLAlertView.SCLAppearance(
//            showCircularIcon: true
//        )
//        let alertView = SCLAlertView(appearance: appearance)
//        let alertViewIcon = UIImage(named: "1") //Replace the IconImage text with the image name
//        alertView.showInfo("Custom icon", subTitle: "This is a nice alert with a custom icon you choose", circleIconImage: alertViewIcon)
             
        ServerController.shared.getPokemonData()
        initializeSearchBar()
    }
    
   
    func initializeSearchBar() {
        searchController.searchBar.placeholder = "Search for Pokémon"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredPokedex = arrayPokedex.filter { pokemon in
//            return pokemon[.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        tableView.reloadData()
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
//        Pokemon p = PokemonDao.shared.getPokemonb
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        cell.pokeID.capsuleLabel.text = "#" + formatter.string(from: PokemonDao.shared.pokedexCache[indexPath.row].poke_id as NSNumber)!
        
        if let pkmnImage:UIImage = UIImage(named: "\(PokemonDao.shared.pokedexCache[indexPath.row].poke_id as! Int32).png") {
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
