//
//  ContentView.swift
//  Boera
//
//  Created by Julian Schumacher on 06.05.25.
//

import SwiftUI
import CoreData

internal struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    /// All drink entries sorted by timestamp
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DrinkEntry.timestamp, ascending: true)],
        animation: .default
    )
    private var entries: FetchedResults<DrinkEntry>
    
    /// Whether or not the sheet to add a new entry is shown
    @State private var addEntryShown: Bool = false
    
    var body: some View {
        NavigationStack {
            // If entries is empty, this is shown in the middle of the screen. Because entries is empty, the list down further isn't rendered.
            // TODO: add image of bo
            homeBody()
            .sheet(isPresented: $addEntryShown) {
                AddEntrySheet()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        addEntryShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Hi👋")
        }
    }
    
    @ViewBuilder
    private func homeBody() -> some View {
        if entries.isEmpty {
            VStack(alignment: .center) {
                Text("No entries added yet - drink something to start🚰")
                    .multilineTextAlignment(.center)
                    .padding(.all, 24)
            }
        } else {
            List(entries) {
                entry in
                entryContainer(entry)
            }
        }
    }
    
    /// Builds a single line of the list for a single entry in the list of drink entries
    @ViewBuilder
    private func entryContainer(_ entry : DrinkEntry) -> some View {
        HStack {
            Text("\(entry.amount) ml")
            Spacer()
            Text(entry.timestamp!, style: .date)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
