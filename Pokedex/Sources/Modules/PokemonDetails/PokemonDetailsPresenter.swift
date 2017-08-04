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

    func performSave(_ pokemon : Pokemon)
    {
        interactor?.save(pokemon)
    }

    /*func performLoadPokemonImage(from url : String, successCallBack : PokemonImageLoadingSuccessCallback?)
    {
        interactor?.loadPokemonImage(from: url, successCallBack: successCallBack, failureCallback: { self.handle($0) })
    }*/

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
