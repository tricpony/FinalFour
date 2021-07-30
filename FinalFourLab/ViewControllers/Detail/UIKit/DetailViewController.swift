//
//  DetailViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    var product: Product?
    var imageView = UIImageView()

    private func configureView() {
        let mainStackView = UIStackView.stack()
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        
        let detailStackView = UIStackView.stack(axis: .vertical)
        detailStackView.alignment = .center
        detailStackView.add([imageView])

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.add(detailStackView)
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2),
//            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3)
        ])

        // configure image view
        guard let imageData = product?.imageData else { return }
        imageView.image = UIImage(data: imageData)
//        let height = imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2)
//        let width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2)
//        imageView.addConstraints([height, width])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        title = "Details"
    }
}
