//
//  DetailViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    var product: Product?
    var label = UILabel()

    private func configureView() {
        let stackView = UIStackView.stack(axis: .vertical)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.add(label)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        label.text = "Hello World"
        title = product?.title
    }
}
