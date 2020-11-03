//
//  PreviewMode.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-12.
//

import SwiftUI

struct PreviewMode: ViewModifier {
    let scheme: ColorScheme
    let width: CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(Color(.textBackgroundColor))
            .previewLayout(PreviewLayout.fixed(width: width, height: height))
            .environment(\.colorScheme, scheme)
    }
}
