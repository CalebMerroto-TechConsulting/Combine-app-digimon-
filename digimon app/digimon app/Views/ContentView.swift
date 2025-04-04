//
//  ContentView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var search: Search<Digimon>
    @StateObject var viewModel: ViewModel<Digimon> = ViewModel<Digimon>()
    @State var viewMode = "list"
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Digi.name, ascending: false)],
        animation: .default)
    private var digis: FetchedResults<Digi>
    
    @State private var digimons: [Digimon] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    
                    ListView(viewModel: viewModel, digis: $digimons)
                        .tabItem {
                            Label("List", systemImage: "list.bullet")
                        }
                    
                    LazyHGridView(viewModel: viewModel)
                        .tabItem {
                            Label("Lazy HGrid", systemImage: "rectangle.grid.1x2")
                        }

                    LazyVGridView(viewModel: viewModel)
                        .tabItem {
                            Label("Lazy VGrid", systemImage: "square.grid.2x2")
                        }
                }
            }
        }
        .navigationTitle("Digimon List")
        .searchable(text: $search.query, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by...")
        .task {
            if digis.isEmpty{
                viewModel.fetchData(search,url)
                digimons = digis.map { Digimon($0) }
            }
        }
        .onChange(of: search.query) {
            if digis.isEmpty{
                Task {
                    viewModel.fetchData(search, url)
                    digimons = digis.map { Digimon($0) }
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(Search<Digimon>())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
