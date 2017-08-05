//
//  DatabaseManager.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import RealmSwift

final class DatabaseProvider
{
    private static let shouldDeleteRealm = false                                                                // Clean db at startup
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))      // Avoid migration

    // Can't init this is a singleton
    private init()
    {
        guard DatabaseProvider.shouldDeleteRealm else { return }
        do
        {
            try realm.write
            {
                realm.deleteAll()
            }
            print("realm deleted")
        }
        catch let error
        {
            print("Error : \(error.localizedDescription)")
        }
    }

    //MARK: Shared Instance

    static let shared: DatabaseProvider = DatabaseProvider()

    func queryPokemons(filterByPokemonNameOrTypeName filter : String?) -> Results<Pokemon>
    {
        if let filter = filter
        {
            let predicate = NSPredicate(format: "name CONTAINS %@ OR ANY types.name CONTAINS %@", filter, filter)
            return realm.objects(Pokemon.self).sorted(byKeyPath: "id", ascending : true).filter(predicate)
        }
        else
        {
            return realm.objects(Pokemon.self).sorted(byKeyPath: "id", ascending : true)
        }
    }

    @discardableResult
    func insert(_ pokemon : Pokemon) throws -> Pokemon
    {
        try realm.write
        {
            realm.add(pokemon, update: true)
        }
        return pokemon
    }

    func delete(_ pokemon : Pokemon) throws
    {
        try realm.write
        {
            realm.delete(pokemon)
        }
    }

    func getPokemon(with name : String) -> Pokemon?
    {
        return realm.object(ofType: Pokemon.self, forPrimaryKey: name)
    }
}
