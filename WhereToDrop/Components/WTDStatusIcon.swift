//
//  WTDStatusIcon.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-12.
//

import SwiftUI

struct WTDStatusIcon: View {
    let active: Bool

    var body: some View {
        Circle().fill(Color(active ? .systemGreen : .systemRed))
    }
}

struct WTDStatusIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                WTDStatusIcon(active: true)
                WTDStatusIcon(active: false)
            }
            .modifier(PreviewMode(scheme: .light, width: 100, height: 50))
            HStack {
                WTDStatusIcon(active: true)
                WTDStatusIcon(active: false)
            }
            .modifier(PreviewMode(scheme: .dark, width: 100, height: 50))
        }
    }
}
