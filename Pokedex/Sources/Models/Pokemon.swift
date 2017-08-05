//
//  Pokemon.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON
import Siesta

class Pokemon: Object
{
    dynamic var id : Int = 0
    dynamic var imageUrl : String?
    dynamic var name : String?
    dynamic var weight : Int = 0
    dynamic var height : Int = 0
    
    let types = List<PokemonType>()
    let stats = List<PokemonStat>()

    override static func primaryKey() -> String?
    {
        return "name"
    }

    override static func ignoredProperties() -> [String]
    {
        return ["image"]
    }

    convenience init?(json : JSON)
    {
        guard let id = json["id"].int, let name = json["name"].string, let weight = json["weight"].int, let height = json["height"].int, let imageUrl = json["sprites"]["front_default"].string else { return nil }
        self.init()
        self.id = id
        self.name = name
        self.weight = weight
        self.height = height
        self.imageUrl = imageUrl
        self.types.removeAll()
        self.types.append(objectsIn: json["types"].arrayValue.flatMap( { PokemonType(json: $0 as JSON) } ))
        self.stats.removeAll()
        self.stats.append(objectsIn :json["stats"].arrayValue.flatMap( { PokemonStat(json: $0 as JSON) }))
    }
}
