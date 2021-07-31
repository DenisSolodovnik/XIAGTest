//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

protocol LargePhotView: UIView {
    func displayLoadingState()
    func displayErrorState(_ error: String)
    func hideAllStates()

    func display(photo: UIImage?)
}
