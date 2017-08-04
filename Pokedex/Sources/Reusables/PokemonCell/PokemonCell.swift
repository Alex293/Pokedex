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
    var pokemonName : String?
    {
        didSet
        {
            nameLabel.text = "\(pokemonName ?? "Unknown pokemon")"
        }
    }
    var pokemonUrl : String?

    // MARK: OUTLETS

    @IBOutlet weak var nameLabel: UILabel!

    @IBAction func didTouchSavePokemonButton(_ sender: UIButton)
    {
        
    }
}
