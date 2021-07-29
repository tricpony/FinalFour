//
//  StyleSheet.swift
//  FinalFourLab
//
//  Created by aarthur on 7/29/21.
//

import UIKit

enum TextStyle: Hashable {
    case title(String, CGFloat, UIFont.Weight, UIColor?)
    case author(String, CGFloat, UIFont.Weight, UIColor?)
    
    static var titleStyle: TextStyle = .title(FontStyle.titleFontFamily, FontStyle.titleFontSize, FontStyle.titleWeight, FontStyle.titleColor)
    static var authorStyle: TextStyle = .author(FontStyle.authorFontFamily, FontStyle.authorFontSize, FontStyle.authorWeight, FontStyle.authorColor)
    
    var font: UIFont {
        switch self {
        case .title(let family, let size, let weight, _ ):
            let weight = [UIFontDescriptor.AttributeName.traits: weight]
            let descriptor = UIFontDescriptor().withFamily(family).addingAttributes(weight)
            return UIFont(descriptor: descriptor, size: size)
        case .author(let family, let size, let weight, _ ):
            let weight = [UIFontDescriptor.AttributeName.traits: weight]
            let descriptor = UIFontDescriptor().withFamily(family).addingAttributes(weight)
            return UIFont(descriptor: descriptor, size: size)
        }
    }
}

struct FontStyle {
    static var titleColor = UIColor(named: "title")
    static var titleFontFamily = "AvenirNext"
    static var titleWeight = UIFont.Weight.semibold
    static var titleFontSize: CGFloat = 12.0

    static var authorColor = UIColor(named: "author")
    static var authorFontFamily = "AvenirNext"
    static var authorWeight = UIFont.Weight.regular
    static var authorFontSize: CGFloat = 11.0
}
