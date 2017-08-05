//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import Whisper

class PokemonDetailsViewController: UIViewController, PokemonDetailsViewProtocol
{
	var presenter: PokemonDetailsPresenterProtocol?
    var pokemon : Pokemon?
    {
        didSet
        {
            title = pokemon?.name
            pokemonDetailsTableView.reloadData()
        }
    }
    lazy var saveButton : UIBarButtonItem =
    {
        return UIBarButtonItem(image: UIImage(named : Constant.ImageName.heartLight), style: .plain, target: self, action: #selector(didTouchSaveButton))
    }()

    lazy var unsaveButton : UIBarButtonItem =
    {
        return UIBarButtonItem(image: UIImage(named : Constant.ImageName.heartBold), style: .plain, target: self, action: #selector(didTouchUnsaveButton))
    }()

    @IBOutlet weak var pokemonDetailsTableView: UITableView!
    {
        didSet
        {
            pokemonDetailsTableView.register(cellWithClass: PokemonImageCell.self)
            pokemonDetailsTableView.register(cellWithClass: PokemonInfoCell.self)
            pokemonDetailsTableView.register(cellWithClass: PokemonTypeCell.self)
            pokemonDetailsTableView.register(cellWithClass: PokemonStatCell.self)
            pokemonDetailsTableView.rowHeight = UITableViewAutomaticDimension
            pokemonDetailsTableView.estimatedRowHeight = 50
            pokemonDetailsTableView.tableFooterView = UIView()
        }
    }

	override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = Constant.Text.backButton
        title = Constant.Text.Title.loadingPokemonDetails
        presenter?.viewDidLoad()
    }

    func update(_ pokemon : Pokemon)
    {
        self.pokemon = pokemon
        if presenter?.isSaved(pokemon) ?? false
        {
            navigationItem.rightBarButtonItem = unsaveButton
        }
        else
        {
            navigationItem.rightBarButtonItem = saveButton
        }
    }

    @objc func didTouchSaveButton()
    {
        guard let pokemon = pokemon else { return }
        presenter?.performSave(pokemon)
    }

    @objc func didTouchUnsaveButton()
    {
        guard let pokemon = pokemon else { return }
        presenter?.performUnsave(pokemon)
    }

    func show(_ message : String, isError : Bool)
    {
        var murmur = Murmur(title: message)
        murmur.backgroundColor = isError ? .red : .blue
        murmur.titleColor = .white
        Whisper.show(whistle: murmur, action: .show(2))
    }

    func update(isPokemonSaved : Bool)
    {
        if isPokemonSaved
        {
            navigationItem.rightBarButtonItem = unsaveButton
        }
        else
        {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
}

// MARK: - UITableViewDataSource
extension PokemonDetailsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0: return pokemon?.imageUrl != nil ? 1 : 0
        case 1: return pokemon?.id != nil ? 1 : 0
        case 2: return pokemon?.types.count ?? 0
        case 3: return pokemon?.stats.count ?? 0
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withClass: PokemonImageCell.self), let pokemon = pokemon else { fatalError("PokemonsDetailsViewController : can't initialize PokemonImageCell") }
            presenter?.getImage(for: pokemon, successCallBack:
                {
                    (image) in
                    cell.pokemonImage = image
            })
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withClass: PokemonInfoCell.self), let pokemon = pokemon else { fatalError("PokemonsDetailsViewController : can't initialize PokemonInfoCell") }
            cell.pokemonId = pokemon.id
            cell.pokemonWeight = pokemon.weight
            cell.pokemonHeight = pokemon.height
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withClass: PokemonTypeCell.self), let pokemon = pokemon else { fatalError("PokemonsDetailsViewController : can't initialize PokemonTypeCell") }
            cell.typeName = pokemon.types[indexPath.row].name
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withClass: PokemonStatCell.self), let pokemon = pokemon else { fatalError("PokemonsDetailsViewController : can't initialize PokemonStatCell") }
            cell.statName = pokemon.stats[indexPath.row].name
            cell.statBaseValue = pokemon.stats[indexPath.row].baseValue
            return cell
        default: fatalError("Bad cell requested")
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        guard pokemon != nil else { return nil }
        switch section
        {
        case 1: return Constant.Text.TableHeader.infos
        case 2: return Constant.Text.TableHeader.types
        case 3: return Constant.Text.TableHeader.stats
        default: return nil
        }
    }
}
