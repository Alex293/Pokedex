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
    // MARK: VARS

    var statName : String?
    {
        didSet
        {
            guard let name = statName else { return }
            statNameLabel.text = name
        }
    }
    var statBaseValue : Int?
    {
        didSet
        {
            guard let value = statBaseValue else { return }
            statBaseValueLabel.text = "\(value)"
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statBaseValueLabel: UILabel!
}
