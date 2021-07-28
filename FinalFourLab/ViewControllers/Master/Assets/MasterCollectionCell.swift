//
//  MasterCollectionCell.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import UIKit

class MasterCollectionCell: UICollectionViewListCell {
    var model: Product?

    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = MasterContentConfiguration().updated(for: state)
        newConfiguration.model = model
        newConfiguration.cell = self

        // Trigger UI update
        contentConfiguration = newConfiguration
    }
}
