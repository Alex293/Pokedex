//
//  SavedPokemonsListRouter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class SavedPokemonsListRouter: SavedPokemonsListWireframeProtocol
{
    weak var viewController: UIViewController?

    static func loadModule() -> UIViewController
    {
        // Change to get view from storyboard if not using progammatic UI
        let view = SavedPokemonsListViewController(nibName: nil, bundle: nil)
        let interactor = SavedPokemonsListInteractor()
        let router = SavedPokemonsListRouter()
        let presenter = SavedPokemonsListPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        let savedPokemonListTabBarItem = UITabBarItem(title: Constant.Text.Title.favoritePokemons, image: UIImage(named: Constant.ImageName.heartLight), selectedImage: UIImage(named: Constant.ImageName.heartLight))
        view.tabBarItem = savedPokemonListTabBarItem
        return view
    }

    func routeToPokemonDetails(for pokemon : Pokemon)
    {
        viewController?.navigationController?.pushViewController(PokemonDetailsRouter.loadModule(for : pokemon), animated: true)
    }
}
