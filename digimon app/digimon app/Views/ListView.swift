//
//  ListView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/5/25.
//
import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel<Digimon>
    @EnvironmentObject var search: Search<Digimon>
    @Binding var digis: [Digimon]
    
    var body: some View {
        List {
            if digis.isEmpty {
                ForEach(viewModel.data) { digi in
                    DigimonView(searchText: $search.query, digimon: digi)
                }
            }
            else {
                ForEach(digis) { digi in
                    DigimonView(searchText: $search.query, digimon: digi)
                }
            }
        }
        .refreshable {
            viewModel.fetchData(search, url)
        }
    }
}

#Preview {
    ListView(viewModel: ViewModel<Digimon>(), digis: .constant([]))
        .environmentObject(Search<Digimon>())
}
