//
//  Stackable.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

protocol Stackable {
    func configure(stack: UIStackView)
}

extension UIStackView {

    static func stack(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        return stack
    }
    
    func add(_ stackable: Stackable) {
        stackable.configure(stack: self)
    }

    func add(_ stackables: [Stackable]) {
        stackables.forEach { $0.configure(stack: self) }
    }
}

extension UIView: Stackable {
    
    static func hairline() -> UIView {
        let line = UIView()
        line.backgroundColor = UIColor(named: "hairline")
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        return line
    }

    func configure(stack: UIStackView) {
        stack.addArrangedSubview(self)
    }
    
}

extension CGFloat: Stackable {
    func configure(stack: UIStackView) {
        stack.spacing = self
    }
}

