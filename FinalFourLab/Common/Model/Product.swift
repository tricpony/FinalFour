//
//  Product.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import Foundation

class Product: Codable, Model {
    static func == (lhs: Product, rhs: Product) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    var title: String
    var author: String?
    var imageURL: URL?
    var favorite: Bool?
    var imageData: Data?

    func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
