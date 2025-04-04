//
//  SearchUtil.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI
import Combine

import Foundation

class Search<T: Identifiable & Decodable & Stringable>: ObservableObject {
    @Published var query: String = ""

    func eval(_ item: T) -> Bool {
        guard !query.isEmpty else { return true }
        return item.str.lowercased().contains(query.lowercased())
    }
}
