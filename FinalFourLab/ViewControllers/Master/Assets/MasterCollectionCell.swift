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
        
        // Update any configuration parameters related to data item
        newConfiguration.title = model?.title
        newConfiguration.author = model?.author
        newConfiguration.favorite = model?.favorite

        // Trigger UI update
        contentConfiguration = newConfiguration
    }
}
