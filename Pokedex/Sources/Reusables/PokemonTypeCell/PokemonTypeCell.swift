//
//  PokemonTypeCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 04/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonTypeCell: UITableViewCell
{
    // MARK: VARS

    var typeName : String?
    {
        didSet
        {
            guard let name = typeName else { return }
            typeNameLabel.text = name
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var typeNameLabel: UILabel!
}
