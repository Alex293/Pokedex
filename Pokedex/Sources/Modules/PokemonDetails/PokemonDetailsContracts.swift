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
typealias SavePokemonSuccessCallback = () -> ()
typealias UnsavePokemonSuccessCallback = () -> ()

enum PokemonDetailsError : Error
{
    case noUrl
    case noContent
}

//MARK: Wireframe - External interaction
protocol PokemonDetailsWireframeProtocol: class
{
    static func loadModule(for pokemonNameAndUrl : PokemonNameAndUrl)-> UIViewController
    static func loadModule(for pokemon : Pokemon)-> UIViewController
}

//MARK: Presenter - View -> Presenter
protocol PokemonDetailsPresenterProtocol: class
{
    var interactor: PokemonDetailsInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func isSaved(_ pokemon : Pokemon) -> Bool
    func performSave(_ pokemon : Pokemon)
    func performUnsave(_ pokemon : Pokemon)
    func getImage(for pokemon : Pokemon, successCallBack : GetPokemonImageSuccessCallback?)
}

//MARK: InteractorOutput - Interactor -> Presenter
protocol PokemonDetailsInteractorOutputProtocol: class
{

}

//MARK: InteractorOutput - Presenter -> Interactor
protocol PokemonDetailsInteractorInputProtocol: class
{
    var presenter: PokemonDetailsInteractorOutputProtocol?  { get set }

    func loadPokemon(from url : String, successCallBack : PokemonLoadingSuccessCallback?, failureCallback : PokemonLoadingFailureCallback?)
    func loadLocalImage(for pokemon : Pokemon) -> UIImage?
    func loadDistantImage(for pokemon : Pokemon, successCallBack : PokemonImageLoadingSuccessCallback?, failureCallback : PokemonImageLoadingFailureCallback?)
    func save(_ pokemon: Pokemon, successCallBack : SavePokemonSuccessCallback?) throws
    func unsave(_ pokemon: Pokemon, successCallBack : UnsavePokemonSuccessCallback?) throws
    func isSaved(_ pokemon : Pokemon) -> Bool
}

//MARK: View - Presenter -> ViewController
protocol PokemonDetailsViewProtocol: class
{
    var presenter: PokemonDetailsPresenterProtocol?  { get set }

    func update(_ pokemon : Pokemon)
    func show(_ message : String, isError : Bool)
    func update(isPokemonSaved : Bool)
}
