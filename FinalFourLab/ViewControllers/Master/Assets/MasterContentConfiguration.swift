//
//  MasterContentConfiguration.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

struct MasterContentConfiguration: UIContentConfiguration, Hashable {
    var model: Product?
//    var cell: UICollectionViewListCell?
    
    func makeContentView() -> UIView & UIContentView {
        CellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> MasterContentConfiguration {
        self
    }
}
