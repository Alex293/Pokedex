//
//  PokemonDetailsInteractor.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class PokemonDetailsInteractor: PokemonDetailsInteractorInputProtocol
{
    weak var presenter: PokemonDetailsInteractorOutputProtocol?

    func loadPokemon(from url : String, successCallBack : PokemonLoadingSuccessCallback?, failureCallback : PokemonLoadingFailureCallback?)
    {
        pokeAPI.resource(for: url).addObserver(owner: self)
        {
            (resource, event) in
            switch event
            {
            case .newData(_) :
                // Todo refactor to avoid null pokemon
                let result : Pokemon? = resource.typedContent()
                if result != nil
                {
                    successCallBack?(result!)
                }
                else
                {
                    fatalError("Error")
                }
            case .error :
                guard let error = resource.latestError else { return }
                failureCallback?(error)
            default : break
            }
        }.load()
    }
    
    func loadLocalImage(for pokemon : Pokemon) -> UIImage?
    {
        return FileManager.shared.getLocalImage(for: pokemon)
    }

    func loadDistantImage(for pokemon : Pokemon, successCallBack : PokemonImageLoadingSuccessCallback?, failureCallback : PokemonImageLoadingFailureCallback?)
    {
        guard let imageUrl = pokemon.imageUrl else { failureCallback?(PokemonDetailsError.noUrl) ; return }
        pokeAPI.resource(for: imageUrl).request(.get)
        .onSuccess(
        {
            (entity) in
            guard let image : UIImage = entity.typedContent(ifNone: nil) else
            {
                failureCallback?(PokemonDetailsError.noContent)
                return
            }
            successCallBack?(image)
        })
        .onFailure
        {
            (error) in
            failureCallback?(error)
        }
    }

    func save(_ pokemon: Pokemon, successCallBack : SavePokemonSuccessCallback?) throws
    {
        try DatabaseProvider.shared.insert(pokemon)
        successCallBack?()
    }

    func unsave(_ pokemon: Pokemon, successCallBack : UnsavePokemonSuccessCallback?) throws
    {
        try DatabaseProvider.shared.delete(pokemon)
        successCallBack?()
    }

    func isSaved(_ pokemon : Pokemon) -> Bool
    {
        guard let pokemonName = pokemon.name, DatabaseProvider.shared.getPokemon(with: pokemonName) != nil else { return false }
        return true
    }
}

