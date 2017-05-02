//
//  PokedexTableViewController.swift
//  pokedexx
//
//  Created by binsnoel on 07/04/2017.
//  Copyright © 2017 binsnoel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView

class PokedexTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPokedex = [Pokemon]()
    var loading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeNavBar()
        initializeSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.pkPokeRed
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func initializeNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action:nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action:  #selector(showSearchBar(sender:)))
        
        self.navigationItem.setHidesBackButton(true, animated:false);
        self.navigationItem.title = "Pokédex"
    }
   
    func initializeSearchBar() {
        self.searchController.searchBar.placeholder = "Search for Pokémon"
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false;
        definesPresentationContext = true
    }
    
    func showSearchBar(sender: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = searchController.searchBar
        self.searchController.isActive = true;
        self.searchController.searchBar.isHidden = false
        self.perform(#selector(showKeyboard), with: nil, afterDelay: 0.1)
    }
    
    func showKeyboard() {
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    
    func filterContentForSearchText(searchText: String) {
        filteredPokedex = PokemonDao.shared.pokedexCache.filter { pk in
            return (pk.name?.lowercased().contains(searchText.lowercased()))!
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
        
        cell.pokeID.capsuleLabel.text = Common.format(forId: p.speciesID)
        
        if let pkmnImage:UIImage = UIImage(named: "\(p.id).png") {
            cell.pokeImage.image = pkmnImage
        } else if let unknownImage:UIImage = UIImage(named:"0.png") {
            cell.pokeImage.image = unknownImage
        }
        
        cell.pokeName.text = Common.formatName(p.name!)
        
        if let a = Int(p.typeA!){
            cell.pokeTypeA.setCapsuleView(type: Enums.CapsuleType.PokeType, pokemonType: Enums.PokemonType(rawValue: a)!)
        }
        if let b = Int(p.typeB!){
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
            nextViewController.selectedPokeID = filteredPokedex[indexPath.row].id
        } else {
            nextViewController.selectedPokeID = PokemonDao.shared.pokedexCache[indexPath.row].id
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}


extension PokedexTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            UIView.animate(withDuration: 0.2, animations: {
                self.navigationItem.titleView = nil
                self.initializeNavBar()
                self.filterContentForSearchText(searchText:"")
            }, completion: { finished in })
        }
        else {
            filterContentForSearchText(searchText: searchController.searchBar.text!)
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}
