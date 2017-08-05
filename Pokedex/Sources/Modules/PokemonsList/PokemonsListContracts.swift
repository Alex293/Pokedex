//
//  PokemonsListProtocols.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import Siesta

//MARK: Wireframe - External interaction
protocol PokemonsListWireframeProtocol: class
{
    static func loadModule() -> UIViewController
    func routeToPokemonDetails(for pokemonNameAndUrl : PokemonNameAndUrl)
    func routeToPokemonDetails(for pokemon : Pokemon)
}

//MARK: Presenter - View -> Presenter
protocol PokemonsListPresenterProtocol: class
{
    var interactor: PokemonsListInteractorInputProtocol? { get set }

    func shouldShowLoadMoreCell() -> Bool
    func loadInitialData()
    func loadMoreData()
    func didSelect(_ pokemonNameAndUrl : PokemonNameAndUrl)
    func didSelect(_ pokemon : Pokemon)
    func isPokemonSaved(for name : String) -> Pokemon?
}

//MARK: InteractorOutput - Interactor -> Presenter
protocol PokemonsListInteractorOutputProtocol: class
{
    func didLoadData(pokemonsNameAndUrl: [PokemonNameAndUrl], loadMoreDataUrl : String?, isInitialLoad : Bool)
    func didFailedToLoadData(error : RequestError, isInitialLoad : Bool)
}

//MARK: InteractorOutput - Presenter -> Interactor
protocol PokemonsListInteractorInputProtocol: class
{
    var presenter: PokemonsListInteractorOutputProtocol?  { get set }

    func loadInitialData()
    func loadMoreData(with url : String)
    func isPokemonSaved(for name : String) -> Pokemon?
}

//MARK: View - Presenter -> ViewController
protocol PokemonsListViewProtocol: class
{
    var presenter: PokemonsListPresenterProtocol?  { get set }
    
    func reloadData(pokemonsNameAndUrl : [PokemonNameAndUrl], isInitialLoad : Bool)
    func didFailedToLoadData(errorMessage : String, isInitialLoad : Bool)
}
