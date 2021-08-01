//
//  ProductCollectionCell.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import UIKit
import Combine

class ProductCollectionCell: UICollectionViewListCell {
    var model: Product?
    private var cancellable: AnyCancellable?
    var isFavorite: Bool? {
        didSet {
            // Only whenever this property changes.
            if oldValue != isFavorite {
                setNeedsUpdateConfiguration()
            }
        }
    }

    override var configurationState: UICellConfigurationState {
        var state = super.configurationState

        // Set the custom property on the state.
        state.isFavorite = self.isFavorite ?? false
        return state
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        var newConfiguration = ProductContentConfiguration().updated(for: state)
        newConfiguration.product = model
        newConfiguration.titleStyle = TextStyle.titleStyle
        newConfiguration.authorStyle = TextStyle.authorStyle
        
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        
        // Trigger UI update
        contentConfiguration = newConfiguration
        
        if state.isFavorite != .none {
            cancellable = model?.$favorite.sink { [weak self] favorite in
                self?.isFavorite = favorite
            }
        }
    }
}

extension UIConfigurationStateCustomKey {
    static let isFavorite = UIConfigurationStateCustomKey("com.my-app.MyCell.isFavorite")
}

extension UICellConfigurationState {
    var isFavorite: Bool? {
        get { return self[.isFavorite] as? Bool ?? false }
        set { self[.isFavorite] = newValue }
    }
}


