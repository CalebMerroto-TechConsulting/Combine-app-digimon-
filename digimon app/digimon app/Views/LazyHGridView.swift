//
//  LazyHGridView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/5/25.
//

import SwiftUI

struct LazyHGridView: View {
    @ObservedObject var viewModel: ViewModel<Digimon>
    @EnvironmentObject var search: Search<Digimon>

    // Define a flexible row layout (one per level)
    private let rowLayout = GridItem(.flexible(), spacing: 16)

    // Ordered levels for display
    private let orderedLevels = ["Fresh", "In Training", "Rookie", "Champion", "Ultimate", "Mega", "Armor"]

    var groupedDigimon: [(level: String, digimon: [Digimon])] {
        let grouped = Dictionary(grouping: viewModel.data, by: \.level)
        return orderedLevels.compactMap { level in
            if let digimon = grouped[level] {
                return (level, digimon)
            }
            return nil
        }
    }

    var body: some View {
        ScrollView(.vertical) {  
            VStack(alignment: .leading, spacing: 20) {
                ForEach(groupedDigimon, id: \.level) { level, digimonList in
                    VStack(alignment: .leading) {
                        Text(level)
                            .font(.title2)
                            .bold()
                            .padding(.leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [rowLayout], spacing: 16) {
                                ForEach(digimonList) { digi in
                                    ZStack(alignment: .bottom) {
                                        DigimonImage(digimon: digi, size: 130, shadowColor: digi.evo)
                                            .frame(width: 150)
                                            .padding(.vertical)

                                        VStack {
                                            Spacer()  
                                            Text(digi.name)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .padding(.vertical, 4)
                                                .frame(maxWidth: .infinity)
                                                .background(digi.evo.opacity(0.6)) 
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
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

    return LazyHGridView(viewModel: vm)
        .environmentObject(search)
}
