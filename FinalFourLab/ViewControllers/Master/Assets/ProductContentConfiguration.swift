//
//  ProductContentConfiguration.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

struct ProductContentConfiguration: UIContentConfiguration, Hashable {
    var model: Product?
    var titleStyle: TextStyle?
    var authorStyle: TextStyle?
    
    func makeContentView() -> UIView & UIContentView {
        CellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> ProductContentConfiguration {
        self
    }
}
