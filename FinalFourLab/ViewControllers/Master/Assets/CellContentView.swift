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
    private var activeConfig = ProductContentConfiguration()
    private var hairline: UIView {
        let line = UIView()
        line.backgroundColor = ColorKit.hairline.kitColor
        let height = line.heightAnchor.constraint(equalToConstant: 0.5)
        line.addConstraint(height)
        return line
    }
    
    init(configuration: ProductContentConfiguration) {
        super.init(frame: .zero)
        configureViews()
        apply(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
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
        stackView.add([title, UIView.hairline(), author, UIView.hairline(), imageView, CGFloat(4)])
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

extension CellContentView: UIContentView {
    
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
    
    private func apply(configuration: ProductContentConfiguration) {
        guard activeConfig != configuration else {
            return
        }
        activeConfig = configuration
        title.text = configuration.model?.title
        author.text = configuration.model?.productLabel
        applyStyle(style: configuration.titleStyle)
        applyStyle(style: configuration.authorStyle)

        guard let model = configuration.model, let _ = model.imageData else {
            // load the image
            imageView.performImageService(model: configuration.model)
            return
        }
        imageView.fillImage(model: model)
    }
}

