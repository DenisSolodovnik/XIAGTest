//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import Foundation

final class NetworkFetcherImp: NetworkFetcher {
    func data(url string: String, completion: ((NetworkResponse) -> Void)?) {
        guard let url = URL(string: string) else {
            completion?(.failure("Wrong URL"))
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                completion?(.failure(error?.localizedDescription ?? "Network error"))
                return
            }

            completion?(.success(data))
        }

        task.resume()
    }
}
