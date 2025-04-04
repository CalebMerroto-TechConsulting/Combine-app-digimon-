//
//  Digimon Model.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI
import CoreData

protocol Stringable {
    var str: String { get }
}

class Digimon: Decodable, Identifiable, Stringable {
    let name: String
    let level: String
    let img: String
    
    init(name: String, level: String, img: String) {
        self.name = name
        self.level = level
        self.img = img
    }

    init(_ digi: Digi) {
        self.name = digi.name ?? "Unknown"
        self.level = digi.level ?? "Unknown"
        self.img = digi.img ?? ""
    }
    
    var evo: Color {
        switch level {
        case "Fresh": return Color.teal
        case "In Training", "Training": return Color.blue
        case "Rookie": return Color.green
        case "Champion": return Color.orange
        case "Ultimate": return Color.red
        case "Mega": return Color.purple
        case "Armor": return Color.yellow
        default: return Color.gray
        }
    }
    
    var src: URL {
        URL(string: img) ?? URL(string: "about:blank")!
    }
    
    func saveable(container: NSPersistentContainer) -> Digi {
        let viewContext = container.viewContext
        let savableDat = Digi(context: viewContext)
        
        savableDat.name = name
        savableDat.level = level
        savableDat.img = img
        
        // Save context to persist changes
        do {
            try viewContext.save()
        } catch {
            print("Failed to save Digimon: \(error.localizedDescription)")
        }
        
        return savableDat
    }
    
    var id: String { name }
    
    var str: String { "\(name) (\(level))" }
}
