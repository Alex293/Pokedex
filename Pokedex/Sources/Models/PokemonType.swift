//
//  PokemonType.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON

class PokemonType: Object
{
    dynamic var name : String?
    dynamic var slot : Int = 0

    convenience init?(json : JSON)
    {
        guard let name = json["type"]["name"].string, let slot = json["slot"].int else { return nil }
        self.init()
        self.name = name
        self.slot = slot
    }
}
