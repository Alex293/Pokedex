//
//  FileManager.swift
//  Pokedex
//
//  Created by Alexis Schultz on 04/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

typealias SetLocalImageSuccessCallback = () -> ()

final class FileManager
{
    // Can't init this is a singleton
    private init() {}

    //MARK: Shared Instance

    static let shared: FileManager = FileManager()

    func getLocalImage(for pokemon : Pokemon) -> UIImage?
    {
        guard  let name = pokemon.name else { return nil }
        return UIImage(contentsOfFile: Constant.Path.pokemonImages.appendingPathComponent(name))
    }

    func setLocalImage(for pokemon : Pokemon, _ image : UIImage, successCallback : SetLocalImageSuccessCallback?) throws
    {
        guard  let name = pokemon.name, let data = UIImagePNGRepresentation(image) else { return }
        try data.write(to: URL(fileURLWithPath: Constant.Path.pokemonImages).appendingPathComponent(name))
        successCallback?()
    }

//    func getDocumentsDirectory() -> URL {
//        NSUrlFordi
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
}
