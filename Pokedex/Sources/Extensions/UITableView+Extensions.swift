//
//  UITableView+Extensions.swift
//  Pokedex
//
//  Created by Alexis Schultz on 05/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

extension UITableView
{
    func register<T: UITableViewCell>(cellWithClass name: T.Type)
    {
        register(nib: name.nib, withCellClass: name)
    }
}
