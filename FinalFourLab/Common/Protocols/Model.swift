//
//  Model.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import Foundation

protocol Model: class, Hashable {
    /// Title of the product.
    var title: String { get }
    /// Optional author of the product.
    var author: String? { get }
    /// Optional image url of the product.
    var imageURL: URL? { get }
    /// Display value for product.
    var productLabel: String { get }
    /// Product is slected as a favorite when true.
    var isFavorite: Bool { get set }
    /// Transient property to hold imageURL content.
    var imageData: Data? { get set }
}
