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
    var imageView = UIImageView()
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
        imageView.contentMode = .scaleAspectFit
        let stackView = UIStackView.stack(axis: .vertical)
        stackView.add([title, author, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 7),
            title.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 2),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
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
        title.text = configuration.title
        author.text = configuration.author
    }
}

