//
//  PokemonNameAndUrl.swift
//  Pokedex
//
//  Created by Alexis Schultz on 05/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import SwiftyJSON

struct PokemonNameAndUrl
{
    var name : String?
    var url : String?

    init(json : JSON)
    {
        url = json["url"].string
        name = json["name"].string
    }
}
