//
//  PokemonsListViewController.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import Whisper
import SwifterSwift

class PokemonsListViewController: UIViewController, PokemonsListViewProtocol
{


	var presenter: PokemonsListPresenterProtocol?
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    var pokemons : [PokemonNameAndUrl] = []

    @IBOutlet weak var pokemonsTableView: UITableView!
    {
        didSet
        {
            pokemonsTableView.register(cellWithClass: PokemonNameCell.self)
            pokemonsTableView.register(cellWithClass: LoadMoreCell.self)
            pokemonsTableView.rowHeight = UITableViewAutomaticDimension
            pokemonsTableView.estimatedRowHeight = 50
            pokemonsTableView.tableFooterView = UIView()
        }
    }
    
	override func viewDidLoad()
    {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string:Constant.Text.refreshControl)
        refreshControl.addTarget(self, action: #selector(PokemonsListViewController.didRequestRefresh), for: UIControlEvents.valueChanged)
        pokemonsTableView.refreshControl = refreshControl
        presenter?.loadInitialData()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        tabBarController?.navigationItem.title = Constant.Text.Title.allPokemons
        if let selectedRow = pokemonsTableView.indexPathForSelectedRow
        {
            pokemonsTableView.deselectRow(at: selectedRow, animated: false)
        }
    }

    func didRequestRefresh()
    {
        presenter?.loadInitialData()
    }

    func didRequestLoadMore()
    {
        presenter?.loadMoreData()
    }

    func reloadData(pokemonsNameAndUrl: [PokemonNameAndUrl], isInitialLoad: Bool)
    {
        if isInitialLoad
        {
            self.pokemons.removeAll()
        }
        self.pokemons.append(contentsOf: pokemonsNameAndUrl)
        pokemonsTableView.reloadData()
        refreshControl.endRefreshing()
    }

    func didFailedToLoadData(errorMessage : String, isInitialLoad: Bool)
    {
        defer
        {
            var murmur = Murmur(title: errorMessage)
            murmur.backgroundColor = .red
            murmur.titleColor = .white
            Whisper.show(whistle: murmur, action: .show(2))
        }
        if !isInitialLoad
        {
            guard let lastIdexPath = pokemonsTableView.indexPathForLastRow, let cell = pokemonsTableView.cellForRow(at: lastIdexPath) as? LoadMoreCell else
            {
                return
            }
            cell.activityIndicatorView.stopAnimating()
        }
        else
        {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension PokemonsListViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard section == 0 else { return 0 }
        guard let presenter = presenter else { return 0 }
        return presenter.shouldShowLoadMoreCell() ? pokemons.count + 1 : pokemons.count
    }

    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
    {
        guard indexPath.section == 0 else { fatalError("PokemonsListViewController : bad section") }
        if indexPath.row == pokemons.count
        {
            guard let cell = pokemonsTableView.dequeueReusableCell(withClass: LoadMoreCell.self) else { fatalError("PokemonsListViewController : can't initialize cell with identifier : LoadMoreCell") }
            cell.activityIndicatorView.startAnimating()
            cell.retryCallback = self.didRequestLoadMore
            return cell
        }
        else
        {
            guard let cell = pokemonsTableView.dequeueReusableCell(withClass: PokemonNameCell.self) else { fatalError("PokemonsListViewController : can't initialize cell with identifier : PokemonCell") }
            cell.pokemonNameAndUrl = pokemons[indexPath.row]
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension PokemonsListViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if cell is LoadMoreCell
        {
            didRequestLoadMore()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let pokemonCell = self.pokemonsTableView.cellForRow(at: indexPath) as? PokemonNameCell, let pokemonNameAndUrl = pokemonCell.pokemonNameAndUrl else { return }
        if let name = pokemonNameAndUrl.name, let pokemon = presenter?.isPokemonSaved(for: name)
        {
            presenter?.didSelect(pokemon)
        }
        else
        {
            presenter?.didSelect(pokemonNameAndUrl)
        }
    }
}
