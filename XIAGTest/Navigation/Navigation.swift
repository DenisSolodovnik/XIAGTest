//
//  Navigation.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

protocol Navigation {
    func showLargePhoto(
        photo url: String?,
        photo image: UIImage?,
        completion: ((UIImage?) -> Void)?
    )
    func hideLargePhoto()
}
