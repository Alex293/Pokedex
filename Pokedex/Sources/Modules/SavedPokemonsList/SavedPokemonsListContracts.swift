//
//  SavedPokemonsListProtocols.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: Wireframe - External interaction
protocol SavedPokemonsListWireframeProtocol: class
{
    static func loadModule() -> UIViewController
    func routeToPokemonDetails(for pokemon : Pokemon)
}

//MARK: Presenter - View -> Presenter
protocol SavedPokemonsListPresenterProtocol: class
{
    var interactor: SavedPokemonsListInteractorInputProtocol? { get set }
    
    func getSavedPokemons(filterByPokemonNameOrTypeName filter : String?) -> Results<Pokemon>?
    func performUnsave(_ pokemon : Pokemon)
    func didSelect(_ pokemon : Pokemon)
}

//MARK: InteractorOutput - Interactor -> Presenter
protocol SavedPokemonsListInteractorOutputProtocol: class
{

}

//MARK: InteractorOutput - Presenter -> Interactor
protocol SavedPokemonsListInteractorInputProtocol: class
{
    var presenter: SavedPokemonsListInteractorOutputProtocol?  { get set }

    func getSavedPokemons(filterByPokemonNameOrTypeName filter : String?) -> Results<Pokemon>
    func unsave(_ pokemon : Pokemon)
}

//MARK: View - Presenter -> ViewController
protocol SavedPokemonsListViewProtocol: class
{
    var presenter: SavedPokemonsListPresenterProtocol?  { get set }
}
