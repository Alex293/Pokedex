//
//  PokemonsListPresenter.swift
//  Pokedex
//
//  Created Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.

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

    func didLoadData(pokemons: [(String, String)], loadMoreDataUrl : String?, isInitialLoad : Bool)
    {
        self.loadMoreDataUrl = loadMoreDataUrl
        isLoadingMoreData = false
        view?.reloadData(pokemons: pokemons, isInitialLoad: isInitialLoad)
    }

    func didFailedToLoadData(error: RequestError, isInitialLoad: Bool)
    {
        if !isInitialLoad
        {
            isLoadingMoreData = false
        }
        view?.didFailedToLoadData(errorMessage: error.userMessage, isInitialLoad: isInitialLoad)
    }

    func didSelectPokemon(name : String, url : String)
    {
        router.routeToPokemonDetails(name: name, url: url)
    }
}

/*

-

 func loadNext()
 {
 guard let nextResultsUrl = nextResultsUrl else
 {
 fatalError("EventTagsController : Can't load more result without a next link")
 }
 guard !isLoadingNextResults else
 {
 return
 }
 self.isLoadingNextResults = true
 pokeAPI.resource(for: nextResultsUrl).request(.get)
 .onSuccess(
 {
 [weak self] (entity) in
 let result : (pokemons : [Pokemon], nextResultsUrl : JSON?) = entity.typedContent(ifNone: (pokemons : [], nextResultsUrl : nil))
 self?.nextResultsUrl = result.nextResultsUrl?.string
 self?.pokemons.append(contentsOf: result.pokemons)
 self?.isLoadingNextResults = false
 })
 .onFailure
 {
 [weak self] (error) in
 self?.isLoadingNextResults = false
 print("Error while loading more")
 //Utils.showWhisper(title: "\(error.userMessage)", type: .error)
 if let cell = self?.pokemonsTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? LoadMoreCell
 {
 cell.activityIndicatorView.stopAnimating()
 }
 }
 }

 }


 */
