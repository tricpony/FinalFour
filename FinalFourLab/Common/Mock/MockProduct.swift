//
//  MockProduct.swift
//  FinalFourLab
//
//  Created by aarthur on 7/30/21.
//

import UIKit

/// Mock data used for SwiftUI preview.
class MockProduct: Model {
    static func == (lhs: MockProduct, rhs: MockProduct) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    var title: String
    var author: String?
    var imageURL: URL?
    var imageData: Data? = UIImage(named: "Fallback")?.pngData()
    var productLabel = "productLabel"
    var isFavorite: Bool = false

    init(title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
