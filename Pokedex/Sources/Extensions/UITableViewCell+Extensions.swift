//
//  UITableviewCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 05/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

extension UITableViewCell
{
    var nib: UINib
    {
        return UINib(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }

    class var nib: UINib
    {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
