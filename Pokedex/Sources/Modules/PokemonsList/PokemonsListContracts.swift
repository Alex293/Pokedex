//
//  PokemonsListProtocols.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit
import Siesta

//MARK: Wireframe -
protocol PokemonsListWireframeProtocol: class
{
    static func loadModule() -> UIViewController
    func routeToPokemonDetails(name : String, url : String)
}

//MARK: Presenter -
protocol PokemonsListPresenterProtocol: class
{
    var interactor: PokemonsListInteractorInputProtocol? { get set }

    func shouldShowLoadMoreCell() -> Bool
    func loadInitialData()
    func loadMoreData()
    func didSelectPokemon(name : String, url : String)
}

//MARK: Interactor -
/* Interactor -> Presenter */
protocol PokemonsListInteractorOutputProtocol: class
{
    func didLoadData(pokemons: [(String, String)], loadMoreDataUrl : String?, isInitialLoad : Bool)
    func didFailedToLoadData(error : RequestError, isInitialLoad : Bool)
}

/* Presenter -> Interactor */
protocol PokemonsListInteractorInputProtocol: class
{
    var presenter: PokemonsListInteractorOutputProtocol?  { get set }

    func loadInitialData()
    func loadMoreData(with url : String)
}

//MARK: View -
/* Presenter -> ViewController */
protocol PokemonsListViewProtocol: class
{
    var presenter: PokemonsListPresenterProtocol?  { get set }
    func reloadData(pokemons : [(String, String)], isInitialLoad : Bool)
    func didFailedToLoadData(errorMessage : String, isInitialLoad : Bool)
}
