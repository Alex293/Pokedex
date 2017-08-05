//
//  ActivityIndicatorView.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

protocol ActivityIndicatorDelegate
{
    func didStartAnimating()
    func didStopAnimating()
}

class ActivityIndicatorView : UIActivityIndicatorView
{
    // MARK: VARS

    var delegate : ActivityIndicatorDelegate?

    override func startAnimating()
    {
        super.startAnimating()
        delegate?.didStartAnimating()
    }

    override func stopAnimating()
    {
        super.stopAnimating()
        delegate?.didStopAnimating()
    }
}
