//
//  TestNet.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/6/25.
//

import Foundation
import Combine
@testable import digimon_app


class TestNet: NetworkService {
    func getPublisher(_ urlStr: String) -> AnyPublisher<Data, NetError> {
        guard let fileURL = Bundle.main.url(forResource: urlStr, withExtension: "json") else {
            return Fail(error: NetError.URLError(msg: "\(urlStr).json not found"))
                .eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return Just(data)
                .setFailureType(to: NetError.self)  
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetError.DecodingError(msg: "Failed to load testData.json: \(error.localizedDescription)"))
                .eraseToAnyPublisher()
        }
    }
}
