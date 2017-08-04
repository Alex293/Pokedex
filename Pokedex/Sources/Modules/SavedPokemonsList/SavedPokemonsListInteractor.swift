//
//  SavedPokemonsListInteractor.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.

import RealmSwift

class SavedPokemonsListInteractor: SavedPokemonsListInteractorInputProtocol {

    weak var presenter: SavedPokemonsListInteractorOutputProtocol?

    func getSavedPokemons() -> Results<Pokemon>
    {
        return DatabaseProvider.shared.queryPokemons()
    }
}
