//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

protocol GalleryNetwork {
    func gallery(completion: (([GalleryItem], String) -> Void)?)
    func photo(urlString: String, completion: ((UIImage?, String) -> Void)?)
}
