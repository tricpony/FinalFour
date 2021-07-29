//
//  SplitViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        preferredDisplayMode = .oneBesideSecondary
        preferredSplitBehavior = .tile
        let minimumWidth = min(view.bounds.size.width, view.bounds.size.height)
        minimumPrimaryColumnWidth = minimumWidth / 2
        maximumPrimaryColumnWidth = minimumWidth
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(_ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn
        proposedTopColumn: UISplitViewController.Column)
        -> UISplitViewController.Column {
            return proposedTopColumn
    }

    func splitViewController(_ svc: UISplitViewController,
        displayModeForExpandingToProposedDisplayMode
        proposedDisplayMode: UISplitViewController.DisplayMode)
        -> UISplitViewController.DisplayMode {
            return proposedDisplayMode
    }
}
