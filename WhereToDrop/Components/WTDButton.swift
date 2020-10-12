//
//  WTDButton.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-23.
//

import SwiftUI

struct WTDButton: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .foregroundColor(Color(.textColor))
        })
        .frame(maxWidth: .infinity)
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.textBackgroundColor))
                .shadow(radius: 0.5, x: 0, y: 0.5)
        )
    }
}

struct WTDButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WTDButton(text: "Light Button", action: {})
                .previewLayout(PreviewLayout.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .light)
            WTDButton(text: "Dark Button", action: {})
                .previewLayout(PreviewLayout.fixed(width: 200, height: 200))
                .environment(\.colorScheme, .dark)
        }
    }
}
