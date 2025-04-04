//
//  ViewModel.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//
import Foundation
import Combine
import SwiftUI

class ViewModel<T: Decodable & Identifiable & Stringable>: ViewModelProtocol {
    @Published var data: [T] = []
    @Published var error: NetError?
    @Published var isLoading: Bool = false

    let api: NetworkService
    private var cancellables = Set<AnyCancellable>()

    init(netService: NetworkService = NetLayer()) {
        self.api = netService
    }

    @MainActor
    func fetchData(_ search: Search<T>, _ urlStr: String) {
            isLoading = true
            error = nil
            data = []

            api.getPublisher(urlStr)
                .receive(on: DispatchQueue.main)
                .decode(type: [T].self, decoder: JSONDecoder())
                .map { decodedData in
                    decodedData.filter { search.eval($0) }
                }
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .failure(let error):
                            self.error = NetError.RequestError(msg: error.localizedDescription)
                            self.isLoading = false
                        case .finished:
                            self.isLoading = false
                        }
                    },
                    receiveValue: { filteredData in
                        self.data = filteredData
                    }
                )
                .store(in: &cancellables)
        }
}
