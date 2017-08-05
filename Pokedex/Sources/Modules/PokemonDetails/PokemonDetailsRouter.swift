//
//  PokemonDetailsRouter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class PokemonDetailsRouter: PokemonDetailsWireframeProtocol
{
    weak var viewController: UIViewController?

    static func loadModule(for pokemonNameAndUrl : PokemonNameAndUrl)-> UIViewController
    {
        let view = PokemonDetailsViewController(nibName: nil, bundle: nil)
        let interactor = PokemonDetailsInteractor()
        let router = PokemonDetailsRouter()
        let presenter = PokemonDetailsPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        presenter.pokemonUrl = pokemonNameAndUrl.url

        return view
    }

    static func loadModule(for pokemon : Pokemon) -> UIViewController
    {
        let view = PokemonDetailsViewController(nibName: nil, bundle: nil)
        let interactor = PokemonDetailsInteractor()
        let router = PokemonDetailsRouter()
        let presenter = PokemonDetailsPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        presenter.pokemon = pokemon
        presenter.wasLoadedWithPokemon = true
        
        return view
    }
}
