//
//  DetailViewController.swift
//  SwiftUI
//
//  Created by aarthur on 7/30/21.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    var product: Product

    init(product: Product) {
        self.product = product
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}
