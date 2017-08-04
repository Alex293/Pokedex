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
    var typeName : String?
    {
        didSet
        {
            typeNameLabel.text = "\(typeName ?? "Unknown pokemon")"
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var typeNameLabel: UILabel!
}
