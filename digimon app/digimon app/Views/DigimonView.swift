//
//  DigimonView.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/3/25.
//

import SwiftUI
import CoreData

struct DigimonView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var searchText: String
    let digimon: Digimon

    var body: some View {
        HStack(spacing: 16) {
            DigimonImage(digimon: digimon, size: 94)

            VStack(alignment: .leading, spacing: 6) {
                Text(digimon.name)
                    .font(.headline)
                    .fontWeight(.bold)

                Button(action: {
                    searchText = digimon.level
                }) {
                    Text(digimon.level)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(3)
                        .background(digimon.evo)
                        .cornerRadius(8)
                }
            }
            .padding(.vertical, 8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    
    let fetchRequest: NSFetchRequest<Digi> = NSFetchRequest(entityName: "Digi")
    fetchRequest.fetchLimit = 1
    
    let digi = try! context.fetch(fetchRequest).first!
    
    return DigimonView(
        searchText: .constant(""),
        digimon: Digimon(digi)
    )
    .environment(\.managedObjectContext, context)
}
