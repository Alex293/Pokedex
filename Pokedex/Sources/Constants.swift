//
//  Constants.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation

struct Constant
{
    struct Path
    {
        static let pokemonImages = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }

    struct Text
    {
        struct Title
        {
            static let allPokemons = "All pokemons"
            static let favoritePokemons = "Favorite pokemons"
            static let loadingPokemonDetails = "Loading pokemon details"
        }

        struct Message
        {
            static let pokemonSavedSuccess = "Pokemon added to favorites"
            static let pokemonSavedFailure = "Failed to add pokemon to favorites"
            static let pokemonUnsavedSuccess = "Pokemon removed from favorites"
            static let pokemonUnsavedFailure = "Failed to remove pokemon from favorites"
        }

        struct TableHeader
        {
            static let stats = "Stats :"
            static let types = "Types :"
            static let infos = "Infos :"
        }
        
        static let refreshControl = "Refreshing"
        static let backButton = "Back"
        static let pokemonId = "Id : "
        static let pokemonWeight = "Weight : "
        static let pokemonHeight = "Height : "
    }

    struct ImageName
    {
        static let heartLight = "heartLight"
        static let heartBold = "heartBold"
        static let pokemonLight = "pokemonLight"
        static let pokemonBold = "pokemonBold"
    }
}
