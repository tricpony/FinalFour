//
//  ProductCollectionCell.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import UIKit
import Combine

class ProductCollectionCell: UICollectionViewListCell {
    var product: Product?
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
        var backgroundConfig = UIBackgroundConfiguration.listPlainCell().updated(for: state)

        newConfiguration.product = product
        newConfiguration.titleStyle = TextStyle.titleStyle
        newConfiguration.authorStyle = TextStyle.authorStyle
        
        // background when selected
        backgroundConfig.backgroundColor = state.isSelected ? ColorKit.cellBackgroundSelected.kitColor : .systemBackground
        backgroundConfiguration = backgroundConfig

        // Trigger UI update
        contentConfiguration = newConfiguration
        
        if state.isFavorite != .none {
            cancellable = product?.$favorite.sink { [weak self] favorite in
                // triggered when changing the @Published property favorite on ObservableObject Product
                self?.isFavorite = favorite
            }
        }
    }
}

extension UIConfigurationStateCustomKey {
    // Adding custom configuratino key for favorites
    static let isFavorite = UIConfigurationStateCustomKey("com.my-app.MyCell.isFavorite")
}

extension UICellConfigurationState {
    var isFavorite: Bool? {
        get { return self[.isFavorite] as? Bool ?? false }
        set { self[.isFavorite] = newValue }
    }
}


