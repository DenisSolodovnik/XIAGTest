//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

struct GalleryItem: Decodable {
    let largePhotoUrl: String
    let smallPhotoUrl: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case largePhotoUrl = "url"
        case smallPhotoUrl = "url_tn"
        case name = "name"
    }
}
