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
    private static let shouldDeleteRealm = true
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    // Can't init is singleton
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
    func insertPokemon(withId id : Int, name : String) throws -> Pokemon
    {
        let pokemon = Pokemon()
        try realm.write
        {
            pokemon.id = id
            pokemon.name = name
            realm.add(pokemon, update: true)
        }
        return pokemon
    }

    func savePokemon(withId id : Int, name : String) throws -> Pokemon
    {
        let pokemon = Pokemon()
        try realm.write
        {
            pokemon.id = id
            pokemon.name = name
            realm.add(pokemon, update: true)
        }
        return pokemon
    }

    /*@discardableResult
    func updateTaskList(_ taskList : TaskList, withTitle title : String) throws -> TaskList
    {
        try realm.write
        {
            taskList.title = title
            taskList.updatedAt = Date()
        }
        return taskList
    }*/

    func deletePokemon(_ pokemon : Pokemon) throws
    {
        try realm.write
        {
            realm.delete(pokemon)
        }
    }

    func isInitialLoadComplete() -> Bool
    {
        return realm.objects(Pokemon.self).count > 50
    }
}
