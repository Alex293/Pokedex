//
//  PokemonAbility.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON

class PokemonStat: Object
{
    dynamic var name : String?
    dynamic var baseValue : Int = 0

    convenience init?(json : JSON)
    {
        guard let name = json["stat"]["name"].string, let baseValue = json["base_stat"].int else { return nil }
        self.init()
        self.name = name
        self.baseValue = baseValue
    }
}
