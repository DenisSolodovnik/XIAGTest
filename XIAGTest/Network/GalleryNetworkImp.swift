//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import UIKit

final class GalleryNetworkImp: GalleryNetwork, NetworkAssembly {
    // MARK: - Internal
    func gallery(completion: (([GalleryItem], String) -> Void)?) {
        fetcher.data(url: "https://www.xiag.ch/share/testtask/list.json") { [weak self] response in
            switch response {
            case let .success(data):
                self?.decode(data, completion: completion)
            case let .failure(error):
                completion?([], error)
            }
        }
    }

    func photo(urlString: String, completion: ((UIImage?, String) -> Void)?) {
        var url = urlString
        if !url.contains("s:"),
              let index = urlString.firstIndex(of: Character(":")) {
            url.insert(Character("s"), at: index)
        }
        fetcher.data(url: url) { response in
            switch response {
            case let .success(data):
                guard let image = UIImage(data: data) else {
                    completion?(nil, "Error decoding image")
                    return
                }
                completion?(image, "")
            case let .failure(error):
                completion?(nil, error)
            }
        }
    }

    // MARK: - Private

    private func decode<T>(_ data: Data, completion: ((T?, String) -> Void)?) where T: Decodable {
        decoder.decode(data) { (catalogData: T?, error: String) in
            guard error.isEmpty, let cData = catalogData else {
                completion?(nil, error)
                return
            }

            completion?(cData, error)
        }
    }

    private func decode<T>(_ data: Data, completion: (([T], String) -> Void)?) where T: Decodable {
        decoder.decode(data) { (catalogData: [T], error: String) in
            guard error.isEmpty else {
                completion?([], error)
                return
            }

            completion?(catalogData, error)
        }
    }

    private lazy var fetcher = fetcher
    private lazy var decoder = decoder
}
