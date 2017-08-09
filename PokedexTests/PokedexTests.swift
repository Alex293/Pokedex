//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import XCTest
@testable import Pokedex

class PokedexTests: XCTestCase {
    var pokemonDetailsInteractor :PokemonDetailsInteractor!
    var pokemon : Pokemon!
    var pokemonId : Int!
    var pokemonImageUrl : String!
    var pokemonName : String!
    var pokemonWeight : Int!
    var pokemonHeight : Int!
    
    override func setUp() {
        super.setUp()
        pokemonId = 999
        pokemonImageUrl = "http://dummyUrl"
        pokemonName = "testpokemon"
        pokemonWeight = 66
        pokemonHeight = 99
        pokemonDetailsInteractor = PokemonDetailsInteractor()
        pokemon = Pokemon()
        pokemon.id = pokemonId
        pokemon.name = pokemonName
        pokemon.imageUrl = pokemonImageUrl
        pokemon.height = pokemonHeight
        pokemon.weight = pokemonWeight
        cleanUpDB()
    }
    
    override func tearDown() {
        super.tearDown()
        pokemonDetailsInteractor = nil
        pokemon = nil
        pokemonId = nil
        pokemonImageUrl = nil
        pokemonName = nil
        pokemonWeight = nil
        pokemonHeight = nil
    }
    
    func testSaveGoodPokemon() throws
    {
        try pokemonDetailsInteractor.save(pokemon)
        {
            self.expectation(description: "Pokemon saved").fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        if let pokemonTest = DatabaseProvider.shared.getPokemon(with: pokemonName)
        {
            XCTAssert(pokemonTest.id == pokemon.id)
            XCTAssert(pokemonTest.name == pokemon.name)
            XCTAssert(pokemonTest.imageUrl == pokemon.imageUrl)
            XCTAssert(pokemonTest.height == pokemon.height)
            XCTAssert(pokemonTest.weight == pokemon.weight)
        }
        else
        {
            XCTFail("Failed to save pokemon")
        }
    }

    func testUnsavePokemon() throws
    {
        try DatabaseProvider.shared.insert(pokemon)

        try pokemonDetailsInteractor.unsave(pokemon)
        {
            self.expectation(description: "Pokemon unsaved").fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertNil(DatabaseProvider.shared.getPokemon(with: pokemonName))
    }

    func cleanUpDB()
    {
        if let pokemonTest = DatabaseProvider.shared.getPokemon(with: pokemonName)
        {
            try! DatabaseProvider.shared.delete(pokemonTest)
        }
    }
}
