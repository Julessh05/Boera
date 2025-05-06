//
//  BoeraApp.swift
//  Boera
//
//  Created by Julian Schumacher on 06.05.25.
//

import SwiftUI

@main
struct BoeraApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
