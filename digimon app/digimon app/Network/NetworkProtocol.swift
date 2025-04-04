//
//  NetworkProtocol.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//
import Foundation
import Combine

protocol NetworkService {
    func getPublisher(_ urlStr: String) -> AnyPublisher<Data, NetError> 
}


enum NetError: Error {
    case URLError(msg: String)
    case RequestError(msg: String)
    case ResponseError(code: Int, msg: String)
    case DecodingError(msg: String)
    
    var msg: String {
        switch self {
            case .URLError(msg: let msg):
                return msg
            case .RequestError(msg: let msg):
                return msg
            case .ResponseError(code: let code, msg: let msg):
                return "\(code): \(msg)"
            case .DecodingError(msg: let msg):
                return msg
        }
    }
}
