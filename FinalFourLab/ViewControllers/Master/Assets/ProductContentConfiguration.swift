//
//  ProductContentConfiguration.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

/// Defines configuration of collection view cell's content view.
struct ProductContentConfiguration: UIContentConfiguration, Hashable {
    var product: Product?
    var titleStyle: TextStyle?
    var authorStyle: TextStyle?
    
    // needed so that Hashable works right
    var isFav = false
    
    func makeContentView() -> UIView & UIContentView {
        ProductCellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> ProductContentConfiguration {
        guard let state = state as? UICellConfigurationState else {
            return self
        }

        guard state.isFavorite != .none else { return self }
        var updatedConfiguration = self
        updatedConfiguration.product = product
        updatedConfiguration.titleStyle = titleStyle
        updatedConfiguration.authorStyle = authorStyle
        updatedConfiguration.isFav = state.isFavorite ?? false

        return updatedConfiguration
    }
}
