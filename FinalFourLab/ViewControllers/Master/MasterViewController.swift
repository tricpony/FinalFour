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
        let cellRegistration = UICollectionView.CellRegistration<MasterCollectionCell, Product> { (cell, indexPath, item) in
            cell.model = item
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
        collectionView.backgroundColor = UIColor(named: "gridBackground")
        
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return 0
//    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
//        return cell
//    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
