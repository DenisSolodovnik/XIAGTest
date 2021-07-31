//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

final class GalleryViewImp: UIView, GalleryView {
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        configurate()
    }

    // MARK: - Internal

    var onCellWillAppear: ((Int) -> Void)?
    var onCellDidSelect: ((Int) -> Void)?

    func displayLoadingState() {
        loadingStateView.display(uiView: self)
    }

    func displayErrorState(_ error: String) {
        errorStateView.display(error: error, uiView: self)
    }

    func hideAllStates() {
        loadingStateView.hide()
        errorStateView.hide()
    }

    func display(data: [GalleryCellData]) {
        galleryData = data
        collectionView.reloadData()
    }

    func updateCellData(with data: GalleryCellData, index: Int) {
        galleryData[index] = data
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }

    // MARK: - Private

    private var galleryData: [GalleryCellData] = []

    private lazy var loadingStateView: LoadingStateView = {
        LoadingStateView()
    }()

    private lazy var errorStateView: ErrorStateView = {
        ErrorStateView()
    }()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private var collectionViewLayout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1.0),
              heightDimension: .absolute(106)
            )
            let group = NSCollectionLayoutGroup.horizontal(
              layoutSize: groupSize,
              subitem: item,
              count: 3
            )

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            section.contentInsets = .init(top: 15, leading: 10, bottom: 10, trailing: 10)

            return section
        }
    }

    private func configurate() {
        backgroundColor = .white
        collectionView.backgroundColor = .clear

        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        collectionView.register(
            UINib(
                nibName: "GalleryCell",
                bundle: Bundle(
                    identifier: String(describing: GalleryCell.self)
                )
            ),
            forCellWithReuseIdentifier: "GalleryCell"
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Collections delegates
extension GalleryViewImp: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath)
        if let galleryCell = cell as? GalleryCell {
            galleryCell.setup(with: galleryData[indexPath.item])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCellDidSelect?(indexPath.item)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        onCellWillAppear?(indexPath.item)
    }
}
