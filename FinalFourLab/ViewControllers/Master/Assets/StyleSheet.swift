//
//  StyleSheet.swift
//  FinalFourLab
//
//  Created by aarthur on 7/29/21.
//

import UIKit

enum ColorKit: String {
    case authorText
    case detailBackground
    case hairline
    case gridBackground
    case titleText
    case detailTitleBackground
    case cellBackgroundSelected = "CellBackgroundSelected"
    
    /// Color of enum.
    var kitColor: UIColor? {
        UIColor(named: rawValue)
    }
}

enum TextStyle: Hashable {
    case title(String, CGFloat, UIColor?)
    case author(String, CGFloat, UIColor?)
    
    static var titleStyle: TextStyle = .title(FontStyle.titleFontFamily, FontStyle.titleFontSize, FontStyle.titleColor)
    static var authorStyle: TextStyle = .author(FontStyle.authorFontFamily, FontStyle.authorFontSize, FontStyle.authorColor)
    
    var font: UIFont? {
        switch self {
        case .title(let family, let size, _ ):
            return UIFont(name: family, size: size)
        case .author(let family, let size, _ ):
            return UIFont(name: family, size: size)
        }
    }
}

struct FontStyle {
    static var titleColor = ColorKit.titleText.kitColor
    static var titleFontFamily = "AvenirNext-DemiBold"
    static var titleFontSize: CGFloat = 12.0

    static var authorColor = ColorKit.authorText.kitColor
    static var authorFontFamily = "AvenirNext-Regular"
    static var authorFontSize: CGFloat = 11.0
}
