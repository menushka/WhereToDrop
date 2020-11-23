//
//  View+Extensions.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-11-05.
//

import SwiftUI
import AppKit

extension View {
    func onNSView(added: @escaping (NSView) -> Void) -> some View {
        NSViewAccessor(onNSViewAdded: added) { self }
    }
}

struct NSViewAccessor<Content>: NSViewRepresentable where Content: View {
    var onNSView: (NSView) -> Void
    var viewBuilder: () -> Content

    init(onNSViewAdded: @escaping (NSView) -> Void, @ViewBuilder viewBuilder: @escaping () -> Content) {
        self.onNSView = onNSViewAdded
        self.viewBuilder = viewBuilder
    }

    func makeNSView(context: Context) -> NSViewAccessorHosting<Content> {
        return NSViewAccessorHosting(onNSView: onNSView, rootView: self.viewBuilder())
    }

    func updateNSView(_ nsView: NSViewAccessorHosting<Content>, context: Context) {
        nsView.rootView = self.viewBuilder()
    }
}

class NSViewAccessorHosting<Content>: NSHostingView<Content> where Content : View {
    var onNSView: ((NSView) -> Void)

    init(onNSView: @escaping (NSView) -> Void, rootView: Content) {
        self.onNSView = onNSView
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    override func didAddSubview(_ subview: NSView) {
        super.didAddSubview(subview)
        onNSView(subview)
    }
}
