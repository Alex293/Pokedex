//
//  SavedPokemonsListPresenter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import RealmSwift

class SavedPokemonsListPresenter: SavedPokemonsListPresenterProtocol, SavedPokemonsListInteractorOutputProtocol
{
    weak private var view: SavedPokemonsListViewProtocol?
    var interactor: SavedPokemonsListInteractorInputProtocol?
    private let router: SavedPokemonsListWireframeProtocol

    init(interface: SavedPokemonsListViewProtocol, interactor: SavedPokemonsListInteractorInputProtocol?, router: SavedPokemonsListWireframeProtocol)
    {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getSavedPokemons(filterByPokemonNameOrTypeName filter : String?) -> Results<Pokemon>?
    {
        return interactor?.getSavedPokemons(filterByPokemonNameOrTypeName: filter)
    }

    func performUnsave(_ pokemon: Pokemon)
    {
        interactor?.unsave(pokemon)
    }

    func didSelect(_ pokemon : Pokemon)
    {
        router.routeToPokemonDetails(for: pokemon)
    }
}
