//
//  LoadMoreCell.swift
//  Pokedex
//
//  Created by Alexis Schultz on 03/08/2017.
//  Copyright © 2017 Alexis Schultz. All rights reserved.
//

import UIKit

class LoadMoreCell : UITableViewCell
{
    // MARK: LETS

    // MARK: VARS

    var retryCallback : (()->Void)?

    // MARK: OUTLETS

    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!
    {
        didSet
        {
            activityIndicatorView.delegate = self
            activityIndicatorView.startAnimating()

        }
    }

    // MARK: ACTIONS

    @IBAction func didTouchRetryButton(_ sender: UIButton)
    {
        retryCallback?()
    }

    // MARK: LIFE CYCLE

    // MARK: PUBLIC FUNCTIONS

    // MARK: HELPERS
}

extension LoadMoreCell : ActivityIndicatorDelegate
{
    func didStartAnimating()
    {
        retryButton?.isHidden = true
    }

    func didStopAnimating()
    {
        retryButton?.isHidden = false
    }
}
