//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import Foundation

final class DataDecoderImp: DataDecoder {
    func decode<T>(_ data: Data, completion: ((T?, String) -> Void)?) where T: Decodable {
        do {
            let decodedData: T = try JSONDecoder().decode(T.self, from: data)
            completion?(decodedData, "")
        } catch {
            completion?(nil, "Decode error")
        }
    }

    func decode<T>(_ data: Data, completion: (([T], String) -> Void)?) where T: Decodable {
        do {
            let decodedData: [T] = try JSONDecoder().decode([T].self, from: data)
            completion?(decodedData, "")
        } catch {
            completion?([], "Decode error")
        }
    }
}
