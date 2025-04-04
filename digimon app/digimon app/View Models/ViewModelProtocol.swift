//
//  ViewModelProtocol.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype DataType: Decodable & Identifiable & Stringable
    var data: [DataType] { get set }
    var error: NetError? { get set }
    var api: NetworkService { get }
    var isLoading: Bool { get set }
    func fetchData(_ search: Search<DataType>, _ urlStr: String) async
}
