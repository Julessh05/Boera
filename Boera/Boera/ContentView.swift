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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DrinkEntry.timestamp, ascending: true)],
        animation: .default
    )
    private var entries: FetchedResults<DrinkEntry>
    
    @State private var addEntryShown: Bool = false
    
    var body: some View {
        NavigationStack {
            List(entries) {
                entry in
                entryContainer(entry)
            }
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
            .navigationTitle("Hi")
        }
    }
    
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
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
