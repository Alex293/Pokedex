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
    
    let types = List<PokemonType>()
    let stats = List<PokemonStat>()

    var image : UIImage?
    {
        get
        {
            guard  let name = name else { return nil }
            return UIImage(contentsOfFile: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appendingPathComponent(name))
        }
        set
        {
            guard  let name = name, let image = image, let data = UIImagePNGRepresentation(image) else { return }
            try? data.write(to: URL(fileReferenceLiteralResourceName: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appendingPathComponent(name)))
        }
    }

    override static func primaryKey() -> String?
    {
        return "id"
    }

    override static func ignoredProperties() -> [String]
    {
        return ["image"]
    }

    convenience init(json : JSON)
    {
        self.init()
        //print("init pokemon from json : \(json)")
        id = json["id"].int ?? 0
        name = json["name"].string
        //url = json["url"].string
        
    }

    convenience init(details : PokemonDetails)
    {
        self.init()
        id = details.id
        imageUrl = details.imageUrl
        name = details.name
        types.removeAll()
        types.append(objectsIn: details.types)
        stats.removeAll()
        stats.append(objectsIn :details.stats)
    }
}
