//
//  RootRouter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class RootRouter: RootWireframeProtocol
{
    static func loadModule(in window : UIWindow)
    {
        window.makeKeyAndVisible()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [PokemonsListRouter.loadModule(), SavedPokemonsListRouter.loadModule()]
        window.rootViewController = UINavigationController(rootViewController : tabBarController)
    }
}
