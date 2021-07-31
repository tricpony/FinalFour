//
//  ProductCollectionCell.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import UIKit

class ProductCollectionCell: UICollectionViewListCell {
    var model: Product?

    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = ProductContentConfiguration().updated(for: state)
        newConfiguration.model = model
        newConfiguration.titleStyle = TextStyle.titleStyle
        newConfiguration.authorStyle = TextStyle.authorStyle
        
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        // Trigger UI update
        contentConfiguration = newConfiguration
    }
}
