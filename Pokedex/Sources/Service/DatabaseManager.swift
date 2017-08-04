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
    private static let shouldDeleteRealm = false
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

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

    func queryPokemons() -> Results<Pokemon>
    {
        return realm.objects(Pokemon.self).sorted(byKeyPath: "id", ascending : true)
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
}
