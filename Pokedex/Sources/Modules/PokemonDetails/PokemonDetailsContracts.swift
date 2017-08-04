//
//  PokemonDetailsProtocols.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

typealias PokemonLoadingSuccessCallback = (_ pokemon : Pokemon) -> Void
typealias PokemonLoadingFailureCallback = (_ error : Error) -> Void
typealias PokemonImageLoadingSuccessCallback = (_ image : UIImage) -> Void
typealias PokemonImageLoadingFailureCallback = (_ error : Error) -> Void
typealias GetPokemonImageSuccessCallback = (_ image : UIImage) -> Void


//MARK: Wireframe -
protocol PokemonDetailsWireframeProtocol: class {
    static func loadModule(pokemonName : String, pokemonUrl : String)-> UIViewController
    static func loadModule(for pokemon : Pokemon)-> UIViewController
}
//MARK: Presenter -
protocol PokemonDetailsPresenterProtocol: class {

    var interactor: PokemonDetailsInteractorInputProtocol? { get set }
    func performSave(_ pokemon : Pokemon)
    func viewDidLoad()
    func getImage(for pokemon : Pokemon, successCallBack : GetPokemonImageSuccessCallback?)
}

//MARK: Interactor -
protocol PokemonDetailsInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol PokemonDetailsInteractorInputProtocol: class {

    var presenter: PokemonDetailsInteractorOutputProtocol?  { get set }
    func loadPokemon(from url : String, successCallBack : PokemonLoadingSuccessCallback?, failureCallback : PokemonLoadingFailureCallback?)
    func loadLocalImage(for pokemon : Pokemon) -> UIImage?
    func loadDistantImage(for pokemon : Pokemon, successCallBack : PokemonImageLoadingSuccessCallback?, failureCallback : PokemonImageLoadingFailureCallback?)
    func save(_ pokemon : Pokemon)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol PokemonDetailsViewProtocol: class {

    var presenter: PokemonDetailsPresenterProtocol?  { get set }
    func update(_ pokemon : Pokemon)
    func show(_ message : String, isError : Bool)

    /* Presenter -> ViewController */
}
