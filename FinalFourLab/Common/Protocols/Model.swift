//
//  Model.swift
//  FinalFourLab
//
//  Created by aarthur on 7/28/21.
//

import Foundation

protocol Model: class, Hashable {
    var title: String { get }
    var author: String? { get }
    var imageURL: URL? { get }
    var productLabel: String { get }
    var favorite: Bool? { get set }
    var imageData: Data? { get set }
}
