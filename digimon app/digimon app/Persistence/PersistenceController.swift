//
//  PersistenceController.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/12/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Digi") 

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        let sampleDigimons = [
            ("Greymon", "Champion", "https://digimon.shadowsmith.com/img/greymon.jpg"),
            ("Agumon", "Rookie", "https://digimon.shadowsmith.com/img/agumon.jpg"),
            ("Gabumon", "Rookie", "https://digimon.shadowsmith.com/img/gabumon.jpg")
        ]

        for (name, level, img) in sampleDigimons {
            let digimon = Digi(context: viewContext)
            digimon.name = name
            digimon.level = level
            digimon.img = img
        }

        try? viewContext.save()
        return controller
    }()
}
