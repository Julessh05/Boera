//
//  BoeraApp.swift
//  Boera
//
//  Created by Julian Schumacher on 06.05.25.
//

import SwiftUI

@main
struct BoeraApp: App {
    static private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     BoeraApp.persistenceController.container.viewContext
                )
                .onAppear {
                    SettingsHelper.updateSettings()
                }
        }
    }
}
