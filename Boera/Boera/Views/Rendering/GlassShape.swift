//
//  GlassShape.swift
//  Boera
//
//  Created by Julian Schumacher on 11.05.25.
//

import Foundation
import SwiftUI

/// Shape of glass to render as mask for the water
internal struct GlassShape : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topWidth = rect.width * 0.8
        let bottomWidth = rect.width * 0.6
        let upperLeft = CGPoint(x: rect.midX - topWidth / 2, y: rect.minY)
        let control1 = CGPoint(x: rect.midX - topWidth / 4, y: rect.minY + 25)
        let control2 = CGPoint(x: rect.midX + topWidth / 4, y: rect.minY + 25)
        let upperRight = CGPoint(x: rect.midX + topWidth / 2, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.midX - bottomWidth / 2, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.midX + bottomWidth / 2, y: rect.maxY)
        path.move(to: upperLeft)
        path.addCurve(
            to: upperRight,
            control1: control1,
            control2: control2,
        )
        path.addLine(to: bottomRight)
        path.addLine(to: bottomLeft)
        path.closeSubpath()
        return path
    }
}
