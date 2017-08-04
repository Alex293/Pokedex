//
//  PokemonsListRouter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.

import UIKit

class PokemonsListRouter: PokemonsListWireframeProtocol
{

    weak var viewController: UIViewController?

    static func loadModule() -> UIViewController
    {
        // Change to get view from storyboard if not using progammatic UI
        let view = PokemonsListViewController(nibName: nil, bundle: nil)
        let interactor = PokemonsListInteractor()
        let router = PokemonsListRouter()
        let presenter = PokemonsListPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        let pokemonListTabBarItem = UITabBarItem(title: "All pokemons", image: UIImage(named: "pokemonLight"), selectedImage: UIImage(named: "pokemonBold"))
        view.tabBarItem = pokemonListTabBarItem

        return view
    }

    func routeToPokemonDetails(name : String, url : String)
    {
        viewController?.navigationController?.pushViewController(PokemonDetailsRouter.loadModule(pokemonName: name, pokemonUrl: url), animated: true)
    }
}
