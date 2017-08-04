//
//  PokemonStatCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 04/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonStatCell: UITableViewCell
{
    var statName : String?
    {
        didSet
        {
            statNameLabel.text = "\(statName ?? "Unknown pokemon")"
        }
    }
    var statBaseValue : Int?
    {
        didSet
        {
            statBaseValueLabel.text = statBaseValue != nil ? "\(statBaseValue!)" : "Unknown value"
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statBaseValueLabel: UILabel!
}
