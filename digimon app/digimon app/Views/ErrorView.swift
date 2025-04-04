//
//  ErrorView.swift
//  SwiftUI-API-call-Practice
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: ViewModel<Digimon>
    @ObservedObject var search: Search<Digimon>
    let msg: String
    let urlStr: String = url
    var body: some View {
        VStack(spacing: 16) {
            Text("🚫 Error: \(msg)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()

            Button("Retry") {
                Task { viewModel.fetchData(search,urlStr) }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
