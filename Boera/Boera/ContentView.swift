//
//  ContentView.swift
//  Boera
//
//  Created by Julian Schumacher on 05.05.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationSplitView {
            List {
                
            }
            .toolbar {
                
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
