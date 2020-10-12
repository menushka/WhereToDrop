//
//  WTDSpinner.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-11.
//

import SwiftUI

struct WTDSpinner: View {
    
    @State private var spin = false
    
    var body: some View {
        WTDSpinnerShape()
            .fill(Color(.textColor))
            .rotationEffect(.radians(spin ? 2 * .pi : 0))
            .animation(Animation.linear.repeatForever(autoreverses: false).speed(0.25))
            .onAppear {
                self.spin.toggle()
            }
    }
}

struct WTDSpinnerShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let squareSize = min(rect.width, rect.height)
        let thickness = squareSize * 0.05
        let radius = squareSize / 2 - thickness / 2
        
        var path = Path()
        path.addArc(
            center: center,
            radius: radius,
            startAngle: Angle.init(degrees: 0),
            endAngle: Angle.init(degrees: 90),
            clockwise: true
        )
        return path.strokedPath(.init(lineWidth: thickness))
    }
}

struct WTDSpinner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WTDSpinner()
                .previewLayout(PreviewLayout.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .light)
            WTDSpinner()
                .previewLayout(PreviewLayout.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .dark)
        }
    }
}
