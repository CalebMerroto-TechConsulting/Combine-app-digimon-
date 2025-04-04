//
//  NetworkClasses.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//
import Foundation
import Combine

class NetLayer: NetworkService {
    func getPublisher(_ urlStr: String) -> AnyPublisher<Data, NetError> {
        guard let url = URL(string: urlStr) else {
            return Fail(error: NetError.URLError(msg: "Invalid URL: \(urlStr)"))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetError.ResponseError(code: -1, msg: "Invalid HTTP response")
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetError.ResponseError(
                        code: httpResponse.statusCode,
                        msg: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    )
                }
                
                return output.data
            }
            .mapError { error in
                if let netError = error as? NetError {
                    return netError
                } else {
                    return NetError.RequestError(msg: "Network request failed: \(error.localizedDescription)")
                }
            }
            .eraseToAnyPublisher()
    }
}
