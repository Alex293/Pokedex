//
//  PokemonsListPresenter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit
import Siesta

class PokemonsListPresenter: PokemonsListPresenterProtocol, PokemonsListInteractorOutputProtocol
{
    weak private var view: PokemonsListViewProtocol?
    var interactor: PokemonsListInteractorInputProtocol?
    private let router: PokemonsListWireframeProtocol

    var isLoadingMoreData = false
    var loadMoreDataUrl : String?

    init(interface: PokemonsListViewProtocol, interactor: PokemonsListInteractorInputProtocol?, router: PokemonsListWireframeProtocol)
    {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func shouldShowLoadMoreCell() -> Bool {
        return loadMoreDataUrl != nil
    }

    func loadMoreData()
    {
        guard let loadMoreDataUrl = loadMoreDataUrl, !isLoadingMoreData else { return }
        isLoadingMoreData = true
        interactor?.loadMoreData(with: loadMoreDataUrl)
    }

    func loadInitialData()
    {
        interactor?.loadInitialData()
    }

    func didLoadData(pokemonsNameAndUrl: [PokemonNameAndUrl], loadMoreDataUrl: String?, isInitialLoad: Bool) {
        self.loadMoreDataUrl = loadMoreDataUrl
        isLoadingMoreData = false
        view?.reloadData(pokemonsNameAndUrl: pokemonsNameAndUrl, isInitialLoad: isInitialLoad)
    }

    func didFailedToLoadData(error: RequestError, isInitialLoad: Bool)
    {
        if !isInitialLoad
        {
            isLoadingMoreData = false
        }
        view?.didFailedToLoadData(errorMessage: error.userMessage, isInitialLoad: isInitialLoad)
    }

    func didSelect(_ pokemonNameAndUrl : PokemonNameAndUrl)
    {
        router.routeToPokemonDetails(for : pokemonNameAndUrl)
    }

    func didSelect(_ pokemon: Pokemon)
    {
        router.routeToPokemonDetails(for : pokemon)
    }

    func isPokemonSaved(for name : String) -> Pokemon?
    {
        return interactor?.isPokemonSaved(for: name)
    }
}
