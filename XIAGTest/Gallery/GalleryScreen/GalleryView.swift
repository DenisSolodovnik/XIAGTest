//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

protocol GalleryView: UIView {
    var onCellWillAppear: ((Int) -> Void)? { get set }
    var onCellDidSelect: ((Int) -> Void)? { get set }

    func displayLoadingState()
    func displayErrorState(_ error: String)
    func hideAllStates()

    func display(data: [GalleryCellData])
    func updateCellData(with data: GalleryCellData, index: Int)
}
