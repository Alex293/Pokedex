//
//  PokemonsListInteractor.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.

import UIKit
import Siesta
import SwiftyJSON

class PokemonsListInteractor: PokemonsListInteractorInputProtocol
{
    weak var presenter: PokemonsListInteractorOutputProtocol?

    func loadInitialData()
    {
        pokeAPI.pokemons.addObserver(owner: self)
        {
            [weak self] (resource, event) in
            switch event
            {
            case .newData(_) :
                let result : (pokemons : [(String, String)], loadMoreDataUrl : String?) = resource.typedContent(ifNone: (pokemons : [], loadMoreDataUrl : nil))
                self?.presenter?.didLoadData(pokemons: result.pokemons, loadMoreDataUrl: result.loadMoreDataUrl, isInitialLoad: true)
            case .error :
                guard let error = resource.latestError else { return }
                self?.presenter?.didFailedToLoadData(error: error, isInitialLoad: true)
            default : break
            }
        }.load()
    }

    func loadMoreData(with url: String)
    {
        pokeAPI.resource(for: url).request(.get)
        .onSuccess(
        {
            [weak self] (entity) in
            let result : (pokemons : [(String, String)], loadMoreDataUrl : String?) = entity.typedContent(ifNone: (pokemons : [], loadMoreDataUrl : nil))
            self?.presenter?.didLoadData(pokemons: result.pokemons, loadMoreDataUrl: result.loadMoreDataUrl, isInitialLoad: false)
        })
        .onFailure
        {
            [weak self] (error) in
            self?.presenter?.didFailedToLoadData(error: error, isInitialLoad: false)
        }
    }

    func save(pokemonId : Int, pokemonName : String)
    {
        try? DatabaseProvider.shared.savePokemon(withId: pokemonId, name: pokemonName)
    }
}
