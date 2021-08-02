//
//  ProductCellContentView.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

/// Content view of product collection view cell.
class ProductCellContentView: UIView {
    var title = UILabel()
    var author = UILabel()
    var imageView = LazyImageView()
    var favImageView = UIImageView()
    private var activeConfig = ProductContentConfiguration()
    
    init(configuration: ProductContentConfiguration) {
        super.init(frame: .zero)
        configureView()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create nested stack view containing author label and favorites image.
    var authorStackView: UIStackView {
        let mainStackView = UIStackView.stack()
        let leadingStackView = UIStackView.stack()
        
        // position author label as leading item in stack
        leadingStackView.add(author)
        leadingStackView.alignment = .leading

        // position fav image as trailing item in stack
        let trailingStackView = UIStackView.stack()
        favImageView.contentMode = .scaleAspectFit
        trailingStackView.add(favImageView)
        trailingStackView.alignment = .trailing
        mainStackView.add([leadingStackView, trailingStackView])

        NSLayoutConstraint.activate([
            favImageView.heightAnchor.constraint(equalToConstant: 18),
            favImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
        
        return mainStackView
    }
    
    /// Setup the view.
    private func configureView() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        backgroundColor = .clear
        
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        author.lineBreakMode = .byWordWrapping
        author.numberOfLines = 0
        imageView.contentMode = .scaleAspectFill
        let stackView = UIStackView.stack(axis: .vertical)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.add([title, UIView.hairline(), authorStackView, UIView.hairline(), imageView, CGFloat(4)])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
}

extension ProductCellContentView: UIContentView {
    
    var configuration: UIContentConfiguration {
        get {
            activeConfig
        }
        set {
            guard let newConfig = newValue as? ProductContentConfiguration else {
                return
            }
            apply(configuration: newConfig)
        }
    }

    /// Apply label text style.
    /// - Parameters:
    ///   - style: Text style.
    private func applyStyle(style: TextStyle?) {
        switch style {
        case .title( _ , _ , let color):
            title.textColor = color
            title.font = style?.font
        case .author( _ , _ , let color):
            author.textColor = color
            author.font = style?.font
        default:
            return
        }
    }
    
    /// Apply layout configuration of content view in cell.
    /// - Parameters:
    ///   - configuration: Custom product configuration.
    private func apply(configuration: ProductContentConfiguration) {
        guard activeConfig != configuration else {
            return
        }
        activeConfig = configuration
        title.text = configuration.product?.title
        author.text = configuration.product?.productLabel
        let isFavorite = configuration.product?.isFavorite ?? false
        applyStyle(style: configuration.titleStyle)
        applyStyle(style: configuration.authorStyle)
        favImageView.image = isFavorite ? UIImage(named: "Star") : UIImage()

        guard let model = configuration.product, let _ = model.imageData else {
            // load the image
            imageView.performImageService(model: configuration.product)
            return
        }
        imageView.fillImage(model: model)
    }
}

