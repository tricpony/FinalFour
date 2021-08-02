//
//  LazyImageView.swift
//  TeladocLab
//
//  Created by aarthur on 8/30/20.
//  Copyright © 2020 Gigabit LLC. All rights reserved.
//

import UIKit

/// An image view that will load itself from the url in a Model protocol.
class LazyImageView: UIView {
    var pinwheel = UIActivityIndicatorView()
    var imageView = UIImageView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    private func configureView() {
        // border
        layer.borderWidth = 0
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        pinwheel.style = .medium
        pinwheel.hidesWhenStopped = true
        pinwheel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(pinwheel)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            pinwheel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pinwheel.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ])
    }
    
    func prepareForReuse() {
        imageView.image = .none
    }
    
    /// Fetch image and load into image view.
    /// - Parameters:
    ///   - model: Protocol the product conforms to.
    func performImageService<T: Model>(model: T?) {
        guard let url = model?.imageURL else { return }
        pinwheel.startAnimating()

        ServiceManager.sharedService.startServiceAt(url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.pinwheel.stopAnimating()
            }

            switch result {
            case .success(let payload):
                DispatchQueue.main.async {
                    model?.imageData = payload
                    self?.imageView.contentMode = self?.contentMode ?? .scaleAspectFit
                    self?.imageView.image = UIImage(data: payload)
                }
            case .failure(let error):
                debugPrint("*** Error: \(String(describing: error.errorDescription))")
            }
        }
    }

    /// Load image image view.
    /// - Parameters:
    ///   - model: Protocol the product conforms to.
    func fillImage<T: Model>(model: T) {
        guard let imageData = model.imageData else { return }
        imageView.image = UIImage(data: imageData)
    }
}
