//
//  digimon_appApp.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI

@main
struct digimon_appApp: App {
    @StateObject private var search = Search<Digimon>()
    @StateObject private var screen = ScreenSizeObserver()
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(search)
                .environmentObject(screen)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
