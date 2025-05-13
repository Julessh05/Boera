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
    
    fileprivate static func getPath(in rect : CGRect) -> Path {
        var path = Path()
        let topWidth = rect.width * 0.8
        let bottomWidth = rect.width * 0.6
        let upperLeft = CGPoint(x: rect.midX - topWidth / 2, y: rect.minY + 25)
        let upperRight = CGPoint(x: rect.midX + topWidth / 2, y: rect.minY + 25)
        let bottomLeft = CGPoint(x: rect.midX - bottomWidth / 2, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.midX + bottomWidth / 2, y: rect.maxY)
        path.move(to: upperLeft)
        path.addLine(to: bottomLeft)
        path.addLine(to: bottomRight)
        path.addLine(to: upperRight)
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        // TODO: round corners
        var path = GlassShape.getPath(in: rect)
        let topWidth = rect.width * 0.8
        let upperLeft = CGPoint(x: rect.midX - topWidth / 2, y: rect.minY + 25)
        let bottomControl1 = CGPoint(x: rect.midX + topWidth / 4, y: rect.minY + 50)
        let bottomControl2 = CGPoint(x: rect.midX - topWidth / 4, y: rect.minY + 50)
        path.addCurve(
            to: upperLeft,
            control1: bottomControl1,
            control2: bottomControl2,
        )
        path.closeSubpath()
        return path
    }
}

internal struct GlassShapeTopped : Shape {
    func path(in rect: CGRect) -> Path {
        let topWidth = rect.width * 0.8
        let upperLeft = CGPoint(x: rect.midX - topWidth / 2, y: rect.minY + 25)
        var path = GlassShape.getPath(in: rect)
        let upperControl1 = CGPoint(x: rect.midX + topWidth / 4, y: rect.minY)
        let upperControl2 = CGPoint(x: rect.midX - topWidth / 4, y: rect.minY)
        path.addCurve(
            to: upperLeft,
            control1: upperControl1,
            control2: upperControl2
        )
        path.closeSubpath()
        return path
    }
}
