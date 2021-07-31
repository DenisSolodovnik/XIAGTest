//
//  NetworkFetcher.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import Foundation

protocol NetworkFetcher {
    func data(url string: String, completion: ((NetworkResponse) -> Void)?)
}
