//
//  PokemonInfoCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 05/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import Foundation
import UIKit

class PokemonInfoCell: UITableViewCell
{
    // MARK: VARS

    var pokemonWeight : Int?
    {
        didSet
        {
            guard let weight = pokemonWeight else { return }
            weightLabel.text = Constant.Text.pokemonWeight + "\(weight)"
        }
    }
    var pokemonHeight : Int?
    {
        didSet
        {
            guard let height = pokemonHeight else { return }
            heightLabel.text = Constant.Text.pokemonHeight + "\(height)"
        }
    }
    var pokemonId : Int?
    {
        didSet
        {
            guard let id = pokemonId else { return }
            idLabel.text = Constant.Text.pokemonId + "\(id)"
        }
    }

    // MARK: OUTLETS

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
}
