//
//  MockProduct.swift
//  FinalFourLab
//
//  Created by aarthur on 7/30/21.
//

import Foundation

class MockProduct: Model {
    static func == (lhs: MockProduct, rhs: MockProduct) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    var title: String
    var author: String?
    var imageURL: URL?
    var favorite: Bool?
    var imageData: Data?
    var productLabel = "productLabel"

    init(title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
