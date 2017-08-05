//
//  PokemonsListRouter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class PokemonsListRouter: PokemonsListWireframeProtocol
{
    weak var viewController: UIViewController?

    static func loadModule() -> UIViewController
    {
        let view = PokemonsListViewController(nibName: nil, bundle: nil)
        let interactor = PokemonsListInteractor()
        let router = PokemonsListRouter()
        let presenter = PokemonsListPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        let pokemonListTabBarItem = UITabBarItem(title: Constant.Text.Title.allPokemons, image: UIImage(named: Constant.ImageName.pokemonLight), selectedImage: UIImage(named: Constant.ImageName.pokemonBold))
        view.tabBarItem = pokemonListTabBarItem

        return view
    }

    func routeToPokemonDetails(for pokemonNameAndUrl : PokemonNameAndUrl)
    {
        viewController?.navigationController?.pushViewController(PokemonDetailsRouter.loadModule(for: pokemonNameAndUrl), animated: true)
    }

    func routeToPokemonDetails(for pokemon : Pokemon)
    {
        viewController?.navigationController?.pushViewController(PokemonDetailsRouter.loadModule(for: pokemon), animated: true)
    }
}
