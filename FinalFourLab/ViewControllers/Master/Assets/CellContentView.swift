//
//  CellContentView.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

class CellContentView: UIView {
    var title = UILabel()
    var author = UILabel()
    var imageView = LazyImageView()
    private var activeConfig = MasterContentConfiguration()

    init(configuration: MasterContentConfiguration) {
        super.init(frame: .zero)
        configureViews()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        author.lineBreakMode = .byWordWrapping
        author.numberOfLines = 0
        imageView.contentMode = .scaleAspectFill
        let stackView = UIStackView.stack(axis: .vertical)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.add([title, author, imageView, CGFloat(4)])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        ])
    }
}

extension CellContentView: UIContentView {
    
    var configuration: UIContentConfiguration {
        get {
            activeConfig
        }
        set {
            guard let newConfig = newValue as? MasterContentConfiguration else {
                return
            }
            apply(configuration: newConfig)
        }
    }

    private func apply(configuration: MasterContentConfiguration) {
        guard activeConfig != configuration else {
            return
        }
        activeConfig = configuration
        title.text = configuration.model?.title
        author.text = configuration.model?.author

        guard let model = configuration.model, let _ = model.imageData else {
            // load the image
            imageView.performImageService(model: configuration.model)
//            imageView.performImageService(model: configuration.model) { [weak self] result in
//                switch result {
//                case .success( _ ):
//                    guard let cell = self?.activeConfig.cell else { return }
//                    cell.setNeedsUpdateConfiguration()
//                default:
//                    return
//                }
//            }
            return
        }
        imageView.fillImage(model: model)
//        setNeedsDisplay()
    }
}

