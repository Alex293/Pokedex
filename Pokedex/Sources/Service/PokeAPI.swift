//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import SwiftyJSON
import Siesta

typealias PokemonDetails = (id : Int, name : String, imageUrl : String, stats : [PokemonStat],  types: [PokemonType])

class PokeAPI
{
    private let service = Service(baseURL: "http://pokeapi.co/api/v2/")
    private let swiftyJSONTransformer = ResponseContentTransformer { JSON($0.content as AnyObject) }

    var pokemons: Resource { return service.resource("/pokemon") }

    private struct simpleErrorMessageExtractor: ResponseTransformer
    {
        func process(_ response: Response) -> Response
        {
            switch response
            {
            case .success: return response
            case .failure(var error):
                error.userMessage = error.jsonDict["detail"] as? String ?? error.userMessage
                print("PokeAPI failed \(error.httpStatusCode != nil ? "with http error code : \(error.httpStatusCode!)" : "without http error code")")
                print("PokeAPI failed with error message : \(error.userMessage)")
                return .failure(error)
            }
        }
    }

    init()
    {
        service.configure
        {
            $0.headers["Accept"] = "application/json"
            $0.pipeline[.parsing].add(self.swiftyJSONTransformer, contentTypes: ["*/json"])
            $0.pipeline[.cleanup].add(simpleErrorMessageExtractor())
            $0.useNetworkActivityIndicator()
        }

        service.configureTransformer("/pokemon") { self.pokemonNameAndUrlTransformer(json: $0.content as JSON) }
        service.configureTransformer("/pokemon/*") { self.pokemonNameAndUrlTransformer(json: $0.content as JSON) }
        service.configureTransformer(PokemonIntPattern()) { self.pokemonTransformer(json: $0.content as JSON) }
    }

    func pokemon(id: Int) -> Resource
    {
        return pokemons.child(String(id))
    }

    func resource(for url : String) -> Resource
    {
        return service.resource(absoluteURL: url)
    }

    struct PokemonIntPattern: ConfigurationPatternConvertible
    {
        func configurationPattern(for service: Service) -> (URL) -> Bool {
            return {
                let components = $0.pathComponents
                if components.count > 1 {
                    return (components[components.count - 2] == "pokemon" && Int(components.last!) != nil)
                }
                return false
            }
        }
        var configurationPatternDescription: String {
            return "PokemonIntPattern"
        }
    }

    func pokemonNameAndUrlTransformer(json : JSON) -> ([(String, String)], String?)
    {
        return (json["results"].arrayValue.flatMap( { jsonToPokemonNameAndUrl(json: $0) } ), (json["next"] as JSON?)?.string)
    }

    func jsonToPokemonNameAndUrl(json : JSON) -> (name : String, url : String)?
    {
        guard let name = json["name"].string, let url = json["url"].string else { return nil }
        return (name, url)
    }

    func jsonToPokemonStats(json : JSON) -> [PokemonStat]
    {
        return json.arrayValue.flatMap( { PokemonStat(json: $0) } )
    }

    func jsonToPokemonTypes(json : JSON) -> [PokemonType]
    {
        return json.arrayValue.flatMap( { PokemonType(json: $0) } )
    }

    func pokemonTransformer(json : JSON) -> PokemonDetails?
    {
        guard let id = json["id"].int, let name = json["name"].string, let imageUrl = json["sprites"]["front_default"].string else { return nil }
        return (id : id, name: name, imageUrl: imageUrl, stats : jsonToPokemonStats(json: json["stats"] as JSON), types: jsonToPokemonTypes(json: json["types"] as JSON))
    }
}

let pokeAPI = PokeAPI()
