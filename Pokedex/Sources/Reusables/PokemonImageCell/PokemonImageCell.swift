//
//  File.swift
//  Pokedex
//
//  Created by Alexis Schultz on 04/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonImageCell: UITableViewCell
{
    // MARK: VARS

    var pokemonImage : UIImage?
    {
        didSet
        {
            guard pokemonImageView != nil, let pokemonImage = pokemonImage else { activityIndicatorView.startAnimating() ; return }
            pokemonImageView.image = pokemonImage
            activityIndicatorView.stopAnimating()
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var pokemonImageView: UIImageView!
}
