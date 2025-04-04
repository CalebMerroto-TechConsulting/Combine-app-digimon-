//
//  LazyVGridView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/5/25.
//
import SwiftUI

struct LazyVGridView: View {
    @ObservedObject var viewModel: ViewModel<Digimon>
    @EnvironmentObject var search: Search<Digimon>
    
    // Define a flexible grid layout
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.data.indices, id: \.self) { index in
                    ZStack {
                        DigimonImage(
                                digimon: viewModel.data[index],
                                size: 130,
                                shadowColor: viewModel.data[index].evo
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                        
                        NavigationLink(
                            destination:
                                IndividualDigimonView(digi: $viewModel.data[index])
                            
                        ) {
                            Color.clear.frame(width: 130, height: 130)
                        }
                    }
                }
            }
            .padding()
        }
        .refreshable {
            viewModel.fetchData(search, url)
        }
    }
}

#Preview {
    let vm = ViewModel<Digimon>()
    let search = Search<Digimon>()

    Task {
        await vm.fetchData(search, url)
    }

    return LazyVGridView(viewModel: vm)
        .environmentObject(search)
}
