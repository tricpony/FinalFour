//
//  PlaceholderViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/29/21.
//

import UIKit

class PlaceholderViewController: UIViewController {
    var placeHolderLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        placeHolderLabel.text = "Empty Selection"
        
    }

    private func configureView() {
        let mainStackView = UIStackView.stack()
        let verticalStack = UIStackView.stack(axis: .vertical)
        verticalStack.alignment = .center
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.add(placeHolderLabel)
        mainStackView.add(verticalStack)
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}