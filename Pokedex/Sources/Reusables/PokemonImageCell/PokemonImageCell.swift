//
//  File.swift
//  Pokedex
//
//  Created by Alexis Schultz on 04/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class PokemonImageCell: UITableViewCell
{
    var imageUrl : String?
    {
        didSet
        {
            guard pokemonImageView != nil else { return }
            pokemonImageView.imageURL = imageUrl
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var pokemonImageView: RemoteImageView!
}
