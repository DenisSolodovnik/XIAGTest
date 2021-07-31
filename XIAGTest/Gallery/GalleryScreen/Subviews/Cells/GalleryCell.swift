//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

final class GalleryCell: UICollectionViewCell {
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.backgroundColor = UIColor(named: "CellColor")?.cgColor
        layer.cornerRadius = 15
        logoPhotoView.layer.cornerRadius = 8

        logoPhotoView.image = UIImage(named: "Loading")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        logoPhotoView.image = UIImage(named: "Loading")
    }

    // MARK: - Internal

    func setup(with data: GalleryCellData) {
        if let image = data.previewPhoto {
            logoPhotoView.image = UIImage(data: image)
        }

        nameLabel.text = data.name
    }

    // MARK: - Private
    
    @IBOutlet private weak var logoPhotoView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
}
