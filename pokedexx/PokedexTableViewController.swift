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

class PokedexTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokedex = [Pokemon]()
    var loading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerController.shared.delegate = self
        
        if PokemonDao.shared.pokedexCache.count < 151 {
            ServerController.shared.getPokemonDataById(from: 31, to: 151)
        }
        
        initializeSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.pkPokeRed
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ServerController.shared.delegate = nil
    }
    
   
    func initializeSearchBar() {
        searchController.searchBar.placeholder = "Search for Pokémon"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredPokedex = PokemonDao.shared.pokedexCache.filter { pk in
            return (pk.poke_name?.lowercased().contains(searchText.lowercased()))!
        }
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPokedex.count
        }
        return PokemonDao.shared.pokedexCache.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemoncell", for: indexPath) as! PokedexTableViewCell
        let p : Pokemon
        
        if searchController.isActive && searchController.searchBar.text != "" && filteredPokedex.count > 0{
            p = filteredPokedex[indexPath.row]
        } else {
            p = PokemonDao.shared.pokedexCache[indexPath.row]
        }
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 3
        cell.pokeID.capsuleLabel.text = "#" + formatter.string(from: NSNumber(value:(p.poke_id)))!
        
        if let pkmnImage:UIImage = UIImage(named: "\(p.poke_id).png") {
            cell.pokeImage.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            cell.pokeImage.image = unknownImage
        }
        
        cell.pokeName.text = p.poke_name!
        
        if let a = p.poke_typeA as String! {
            cell.pokeTypeA.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: a)!)
        }
        if let b = p.poke_typeB as String! {
            cell.pokeTypeB.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: b)!)
        }
        
        cell.checkTypes()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "pokemonDetail") as! PokemonDetailViewController
        
        if searchController.isActive && searchController.searchBar.text != "" && filteredPokedex.count > 0{
            nextViewController.pokeID = filteredPokedex[indexPath.row].poke_id
        } else {
            nextViewController.pokeID = PokemonDao.shared.pokedexCache[indexPath.row].poke_id
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


extension PokedexTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension PokedexTableViewController: ServerControllerDelegate {
    func didFinishTask(sender: ServerController) {
        self.tableView.reloadData()
    }
    
    func didFinishSingleTask(sender: ServerController) {
        self.tableView.reloadData()
    }
}

