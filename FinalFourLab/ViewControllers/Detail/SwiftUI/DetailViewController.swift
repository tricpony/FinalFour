//
//  DetailViewController.swift
//  SwiftUI
//
//  Created by aarthur on 7/30/21.
//

import UIKit
import SwiftUI

/// SwiftUI based product detail view controller.  FinalFourSwiftUI target will load this version.
class DetailViewController: UIViewController {
    var product: Product

    init(product: Product) {
        self.product = product
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the view.
    private func configureView() {
        let hostingController = UIHostingController(rootView: DetailContent<Product>(product: product))

        // Add as a child
        addChild(hostingController)

        // Add the SwiftUI view to controller's view hierarchy
        view.addSubview(hostingController.view)

        // Pin edges
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ])
        
        // Notify the hosting controller
        hostingController.didMove(toParent: self)
    }
    
    private func configureNavBar() {
        let imageName = product.isFavorite ? "star-filled" : "star-empty"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(favTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        title = "Details"
    }
    
    @objc
    private func favTapped() {
        // an @Published propery on product will change here
        // triggering the matching cell in MasterViewController
        // to update its content view and display fav icon
        product.isFavorite.toggle()
        configureNavBar()
    }
}
