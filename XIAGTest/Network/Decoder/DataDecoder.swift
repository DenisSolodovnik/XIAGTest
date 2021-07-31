//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import Foundation

protocol DataDecoder {
    /// Decode single object of type `T`
    func decode<T>(_ data: Data, completion: ((T?, String) -> Void)?) where T: Decodable
    /// Decode array of objects of type `T`
    func decode<T>(_ data: Data, completion: (([T], String) -> Void)?) where T: Decodable
}
