//
//  SwiftUIView.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 12.12.25.
//

import SwiftUI

struct Parallelogram: Shape {
    var slant: CGFloat = 20
    var cornerRadius: CGFloat = 16

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Points for left-slanted parallelogram
        let tl = CGPoint(x: rect.minX, y: rect.minY)
        let tr = CGPoint(x: rect.maxX - slant, y: rect.minY)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        let bl = CGPoint(x: rect.minX + slant, y: rect.maxY)

        // Start top-left
        path.move(to: CGPoint(x: tl.x + cornerRadius, y: tl.y))
        path.addLine(to: CGPoint(x: tr.x - cornerRadius, y: tr.y))
        path.addArc(center: CGPoint(x: tr.x - cornerRadius, y: tr.y + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: br.x, y: br.y - cornerRadius))
        path.addArc(center: CGPoint(x: br.x - cornerRadius, y: br.y - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: bl.x + cornerRadius, y: bl.y))
        path.addArc(center: CGPoint(x: bl.x + cornerRadius, y: bl.y - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        path.addLine(to: CGPoint(x: tl.x, y: tl.y + cornerRadius))
        path.addArc(center: CGPoint(x: tl.x + cornerRadius, y: tl.y + cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)

        path.closeSubpath()

        return path
    }
}

#Preview {
    Parallelogram()
        .frame(width: 100, height: 100)
}
