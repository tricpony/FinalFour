//
//  DetailViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

/// UIKit based product detail view controller.
class DetailViewController: UIViewController {
    var product: Product
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var authorLabel = UILabel()
    
    init(product: Product) {
        self.product = product
        self.imageView.accessibilityIdentifier = product.imageURL?.absoluteString ?? "empty"
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Setup the view.
    private func configureView() {
        let mainStackView = UIStackView.stack()
        let infoStackView = UIStackView.stack(axis: .vertical)
        let hairlineTitle = UIView.hairline()
        let hairlineAuthor = UIView.hairline()
        imageView.contentMode = .scaleAspectFill
        
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        infoStackView.alignment = .leading
        infoStackView.distribution = .fill

        let detailStackView = UIStackView.stack(axis: .vertical)
        detailStackView.alignment = .center
        infoStackView.add([titleLabel, hairlineTitle, authorLabel, hairlineAuthor, CGFloat(4)])
        detailStackView.add([infoStackView, imageView, CGFloat(6)])

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.add(detailStackView)
        view.addSubview(mainStackView)
        let widthFraction = CGFloat(7.0/10.0)
        let heightFraction = view.frame.size.width / view.frame.size.height
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthFraction),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightFraction),
            hairlineTitle.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            hairlineAuthor.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])

        // configure image and labels
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        authorLabel.lineBreakMode = .byWordWrapping
        authorLabel.numberOfLines = 0

        guard let imageData = product.imageData else { return }
        imageView.image = UIImage(data: imageData)
        NSLayoutConstraint.activate([
            infoStackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            infoStackView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
        view.backgroundColor = ColorKit.detailBackground.kitColor
        applyStyle()
    }
    
    private func applyStyle() {
        let titleStyle: TextStyle = .title(FontStyle.titleFontFamily, 16, FontStyle.titleColor)
        let authorStyle: TextStyle = .author(FontStyle.authorFontFamily, 15, FontStyle.authorColor)
        [titleStyle, authorStyle].forEach {
            
            switch $0 {
            case .title( _ , _ , let color):
                titleLabel.textColor = color
                titleLabel.font = $0.font
            case .author( _ , _ , let color):
                authorLabel.textColor = color
                authorLabel.font = $0.font
            }
        }
    }

    private func configureNavBar() {
        let imageName = product.isFavorite ? "star-filled" : "star-empty"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(favTapped))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = product.isFavorite ? "on" : "off"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        title = "Details"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // navigation looks choppy
        // suspect split VC is offender
        // better now since moving this from viewDidLoad
        // but still flakey
        configureView()
        titleLabel.text = product.title
        authorLabel.text = product.productLabel
    }
    
    @objc
    private func favTapped() {
        product.isFavorite.toggle()
        configureNavBar()
    }
}
