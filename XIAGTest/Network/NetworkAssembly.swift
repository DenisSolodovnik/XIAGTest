//
//  LargrImageView.swift
//  XIAGTest
//
//  Created by Денис Солодовник on 31.07.2021.
//

import Foundation

protocol NetworkAssembly {
    var fetcher: NetworkFetcher { get }
    var decoder: DataDecoder { get }
}

extension NetworkAssembly {
    var fetcher: NetworkFetcher {
        NetworkFetcherImp()
    }

    var decoder: DataDecoder {
        DataDecoderImp()
    }
}
