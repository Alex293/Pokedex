//
//  PokemonDetailsProtocols.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

//MARK: Wireframe -
protocol PokemonDetailsWireframeProtocol: class {
    static func loadModule(pokemonName : String, pokemonUrl : String) -> UIViewController
}
//MARK: Presenter -
protocol PokemonDetailsPresenterProtocol: class {

    var interactor: PokemonDetailsInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol PokemonDetailsInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didLoad(pokemon : Pokemon)
}

protocol PokemonDetailsInteractorInputProtocol: class {

    var presenter: PokemonDetailsInteractorOutputProtocol?  { get set }

    func loadPokemonDetails(from url : String)
    func loadPokemonImage(from url : String, successCallBack : @escaping (_ image : UIImage) -> Void)
    //func loadPokemonDetails(from id : Int)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol PokemonDetailsViewProtocol: class {

    var presenter: PokemonDetailsPresenterProtocol?  { get set }
    func update(pokemon : Pokemon)

    /* Presenter -> ViewController */
}
