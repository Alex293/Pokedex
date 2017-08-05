//
//  PokemonNameCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 05/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonNameCell: UITableViewCell
{
    // MARK: VARS
    var pokemonNameAndUrl : PokemonNameAndUrl?
    {
        didSet
        {
            if let name = pokemonNameAndUrl?.name
            {
                nameLabel.text = name
            }
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var nameLabel: UILabel!
}
