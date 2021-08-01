//
//  MasterViewController.swift
//  FinalFourLab
//
//  Created by aarthur on 7/27/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class MasterViewController: UIViewController, UICollectionViewDelegate {
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Int, Product>?
    var snapshot: NSDiffableDataSourceSnapshot<Int, Product>?
    var products = [Product]()
    let isCompact: Bool

    init(isCompact: Bool) {
        self.isCompact = isCompact
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerAssets(on collectionView: UICollectionView) {
        let cellRegistration = UICollectionView.CellRegistration<ProductCollectionCell, Product> { (cell, indexPath, item) in
            cell.product = item
        }
        
        // Define data source
        dataSource = UICollectionViewDiffableDataSource<Int, Product>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Product) -> UICollectionViewCell? in
            
            // cell factory, may be new or used cells
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
        
        // snapshot holds my sections and products
        var snapshot = NSDiffableDataSourceSnapshot<Int, Product>()
        snapshot.appendSections([0])
        snapshot.appendItems(products)
        self.snapshot = snapshot

        // Display products
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(66))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 4
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func configureView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        view.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.delegate = self
        collectionView.backgroundColor = ColorKit.gridBackground.kitColor
        
        // Make collection view take up the entire view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        registerAssets(on: collectionView)
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let products = JsonUtility<[Product]>.parseJSON(data) else { return }
        self.products = products
        title = "Products"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureView()
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isCompact {
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
        let product = products[indexPath.row]
        let detailVC = DetailViewController(product: product)
        detailVC.product = product
        if isCompact {
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let nav = UINavigationController(rootViewController: detailVC)
            showDetailViewController(nav, sender: .none)
        }
    }
}
