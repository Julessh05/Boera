//
//  AddEntrySheet.swift
//  Boera
//
//  Created by Julian Schumacher on 06.05.25.
//

import SwiftUI

internal struct AddEntrySheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var amount : Int16 = 250
    
    @State private var errSavingPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Canvas {
                    context, size in
                    let fillLevel = 0.5
                    let waterHeight = size.height * fillLevel
                    let waterRect = CGRect(
                        x: 0,
                        y: size.height - waterHeight,
                        width: size.width,
                        height: waterHeight
                    )
                    let waterPath = Path(waterRect)
                    context.fill(waterPath, with: .color(Color.blue))
                }
                .mask {
                    GlassShape()
                }
                GlassShape()
                    .stroke(style: .init(lineWidth: 2))
                    .foregroundStyle(Color.green)
                GlassShape()
                    .fill()
                    .foregroundStyle(.red)
                    .opacity(0.25)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
            .alert("Error saving", isPresented: $errSavingPresented) {
                
            } message: {
                Text("There's been an error trying to save the new entry. Please try again")
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        // TODO: implement done
                        let entry = DrinkEntry(context: context)
                        entry.amount = amount
                        do {
                            try context.save()
                        } catch {
                            errSavingPresented.toggle()
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddEntrySheet()
}
