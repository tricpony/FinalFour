//
//  MasterContentConfiguration.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

struct MasterContentConfiguration: UIContentConfiguration, Hashable {
    var title: String?
    var author: String?
    var imageURL: URL?
    var favorite: Bool?
    
    func makeContentView() -> UIView & UIContentView {
        CellContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> MasterContentConfiguration {
        self
    }
}
