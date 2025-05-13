//
//  AddEntrySheet.swift
//  Boera
//
//  Created by Julian Schumacher on 06.05.25.
//

import SwiftUI

internal struct AddEntrySheet: View {
    
    private static let maxAmount : Float = 0.5
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.managedObjectContext) private var context
    
    @State private var amount : Float = 0.25
    
    @State private var amountString : String = ""
    
    @State private var errSavingPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(String(format: "%.0f", amount * 1000)) ml")
                    .font(.headline)
                GeometryReader {
                    metrics in
                    ZStack {
                        // Water
                        Canvas {
                            context, size in
                            let waterHeight = size.height * CGFloat(amount / AddEntrySheet.maxAmount)
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
                            GlassShapeTopped()
                        }
                        // Strokes
                        GlassShapeTopped()
                            .stroke()
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.black.opacity(1), .gray.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .opacity(0.5)
                        
                        GlassShape()
                            .stroke()
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.black.opacity(1), .gray.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        // Fills
                        GlassShapeTopped()
                            .fill(.thinMaterial)
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [.black.opacity(0.3), .gray.opacity(0.1)]
                                    ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .opacity(0.5)
                        
                        GlassShape()
                            .fill(.thinMaterial)
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [.black.opacity(0.3), .gray.opacity(0.1)]
                                    ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .opacity(0.8)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged {
                                value in
                                let delta = -value.translation.height
                                guard amount < AddEntrySheet.maxAmount else { return }
                                let sensitivity : CGFloat = 0.000005
                                let newLevel = Float(CGFloat(amount) + delta * sensitivity)
                                guard newLevel <= AddEntrySheet.maxAmount && newLevel >= 0 else { return }
                                amount = Float(newLevel)
                            }
                    )
                    .frame(height: metrics.size.height * 0.9)
                }
            }
            HStack {
                TextField("Amount", text: $amountString)
                    .keyboardType(.decimalPad)
                    .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 16)
                    .textSelection(.enabled)
                    .onChange(of: amountString) {
                        // TODO: disable character input
                        if amountString.isEmpty {
                            amount = 0
                        } else {
                            amount = Float(amountString)!
                        }
                    }
                Text("ml")
            }
            .padding(.horizontal, 128)
        }
        .onAppear {
            amountString = String(amount)
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
                    let entry = DrinkEntry(context: context)
                    entry.amount = Int16(amount * 100)
                    entry.timestamp = Date.now
                    // TODO: add entry.drink
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

#Preview {
    AddEntrySheet()
}
