//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol, PokemonDetailsInteractorOutputProtocol
{
    weak private var view: PokemonDetailsViewProtocol?
    var interactor: PokemonDetailsInteractorInputProtocol?
    private let router: PokemonDetailsWireframeProtocol

    var wasLoadedWithPokemon : Bool = false
    var pokemonUrl : String?
    var pokemon : Pokemon?
    
    init(interface: PokemonDetailsViewProtocol, interactor: PokemonDetailsInteractorInputProtocol?, router: PokemonDetailsWireframeProtocol)
    {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad()
    {
        if wasLoadedWithPokemon
        {
            guard let pokemon = pokemon else { return }
            view?.update(pokemon)
        }
        else
        {
            guard let url = pokemonUrl else { return }
            interactor?.loadPokemon(from: url, successCallBack:
            {
                (pokemon) in
                self.view?.update(pokemon)
            },
            failureCallback: { self.handle($0) })
        }
    }

    func isSaved(_ pokemon: Pokemon) -> Bool
    {
        return interactor?.isSaved(pokemon) ?? false
    }

    func performSave(_ pokemon : Pokemon)
    {
        do
        {
            try interactor?.save(pokemon, successCallBack:
            {
                self.view?.update(isPokemonSaved: true)
                self.view?.show(Constant.Text.Message.pokemonSavedSuccess, isError: false)
            })
        }
        catch let error
        {
            view?.show(Constant.Text.Message.pokemonSavedFailure, isError: true)
            print(error)
        }
    }

    func performUnsave(_ pokemon : Pokemon)
    {
        do
        {
            try interactor?.unsave(pokemon, successCallBack:
            {
                self.view?.update(isPokemonSaved: false)
                self.view?.show(Constant.Text.Message.pokemonUnsavedSuccess, isError: false)
            })
        }
        catch let error
        {
            view?.show(Constant.Text.Message.pokemonUnsavedFailure, isError: true)
            print(error)
        }
    }

    func handle(_ error : Error)
    {
        view?.show(error.localizedDescription, isError: true)
    }

    func getImage(for pokemon : Pokemon, successCallBack : GetPokemonImageSuccessCallback?)
    {
        if let image = interactor?.loadLocalImage(for: pokemon)
        {
            successCallBack?(image)
        }
        else
        {
            interactor?.loadDistantImage(for: pokemon, successCallBack:
            {
                (image) in
                do
                {
                    try FileManager.shared.setLocalImage(for: pokemon, image, successCallback: nil)
                }
                catch let error
                {
                    self.view?.show(error.localizedDescription, isError: true)
                }
                successCallBack?(image)
            },
            failureCallback:
            {
                (error) in
                self.view?.show(error.localizedDescription, isError: true)
            })
        }
    }
}
