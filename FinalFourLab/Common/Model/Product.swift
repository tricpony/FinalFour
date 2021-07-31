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
    var imageData: Data?
    private var favorite: Bool?
    var productLabel: String {
        guard let author = author else {
            return "Product"
        }
        return "By \(author)"
    }
    
    var isFavorite: Bool {
        get {
            favorite ?? false
        }
        set {
            favorite = newValue
        }
    }

    // MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}
