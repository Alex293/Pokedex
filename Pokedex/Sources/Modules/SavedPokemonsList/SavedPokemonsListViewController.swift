//
//  SavedPokemonsListViewController.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class SavedPokemonsListViewController: UIViewController, SavedPokemonsListViewProtocol
{
	var presenter: SavedPokemonsListPresenterProtocol?
    var savedPokemons : Results<Pokemon>?
    var notificationToken: NotificationToken?

    lazy var searchBar:UISearchBar =
    {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        return searchBar
    }()

    @IBOutlet weak var savedPokemonTableView: UITableView!
    {
        didSet
        {
            savedPokemonTableView.register(cellWithClass: PokemonCell.self)
            savedPokemonTableView.rowHeight = UITableViewAutomaticDimension
            savedPokemonTableView.estimatedRowHeight = 50
            savedPokemonTableView.tableFooterView = UIView()
            savedPokemonTableView.tableHeaderView = searchBar
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        requestPokemon(filterByPokemonNameOrTypeName: nil)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        tabBarController?.navigationItem.title = Constant.Text.Title.favoritePokemons
        if let selectedRow = savedPokemonTableView.indexPathForSelectedRow
        {
            savedPokemonTableView.deselectRow(at: selectedRow, animated: false)
        }
    }

    func requestPokemon(filterByPokemonNameOrTypeName filter: String?)
    {
        savedPokemons = presenter?.getSavedPokemons(filterByPokemonNameOrTypeName: filter)
        notificationToken = savedPokemons?.addNotificationBlock
        {
            (changes: RealmCollectionChange) in
            switch changes
            {
            case .initial:
                self.savedPokemonTableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                self.savedPokemonTableView.beginUpdates()
                self.savedPokemonTableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.savedPokemonTableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.savedPokemonTableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.savedPokemonTableView.endUpdates()
                break
            case .error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SavedPokemonsListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return savedPokemons?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withClass: PokemonCell.self) else { fatalError("PokemonsListViewController : can't initialize cell with identifier : PokemonCell") }
        cell.pokemon = savedPokemons![indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete, let pokemon = savedPokemons?[indexPath.row] else { return }
        presenter?.performUnsave(pokemon)
    }

}

// MARK: - UITableViewDelegate
extension SavedPokemonsListViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let pokemon = savedPokemons?[indexPath.row] else { return }
        presenter?.didSelect(pokemon)
    }
}

extension SavedPokemonsListViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText != ""
        {
            requestPokemon(filterByPokemonNameOrTypeName: searchText.lowercased())
        }
        else
        {
            requestPokemon(filterByPokemonNameOrTypeName: nil)
        }
    }
}
