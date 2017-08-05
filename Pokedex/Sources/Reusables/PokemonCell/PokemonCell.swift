//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonCell: UITableViewCell
{
    // MARK: VARS

    var pokemon : Pokemon?
    {
        didSet
        {
            guard let name = pokemon?.name else { return }
            nameLabel.text = name
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var nameLabel: UILabel!
}
