//
//  PathBar.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-11-01.
//

import SwiftUI
import AppKit

struct Arrow: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.addLines([
                    CGPoint(x: geometry.size.width * 0.25, y:  geometry.size.height * 0),
                    CGPoint(x: geometry.size.width * 0.75, y: geometry.size.height * 0.5),
                    CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 1)
                ])
            }
            .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
        }
    }
}

struct PathComponent {
    let image: NSImage
    let name: String
}

struct PathBarItem: View {
    let image: NSImage
    let name: String
    let arrow: Bool
    
    let height: CGFloat
    
    private let padding: CGFloat = 8

    var body: some View {
        HStack(spacing: padding) {
            Image(nsImage: image)
                .resizable()
                .frame(width: height, height: height)
            Text(name)
                .font(.system(size: height / 2))
                .fixedSize(horizontal: true, vertical: false)
                .frame(alignment: .leading)
            if arrow {
                Arrow()
                    .frame(width: height / 5, height: height / 5)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
        .clipped()
    }
}

class InvisibleScroller: NSScroller {
    override class var isCompatibleWithOverlayScrollers: Bool {
        return true
    }
    
    override class func scrollerWidth(for controlSize: NSControl.ControlSize, scrollerStyle: NSScroller.Style) -> CGFloat {
        return 0
    }
}

struct PathBar: View {
    let path: URL
    
    init(path: String) {
        self.path = URL(fileURLWithPath: path)
    }

    var body: some View {
        var parts: [PathComponent] = []
        var currentPath = URL(fileURLWithPath: "")

        for component in self.path.pathComponents {
            currentPath.appendPathComponent(component)
            parts.append(
                PathComponent(
                    image: NSWorkspace.shared.icon(forFile: currentPath.path),
                    name: FileManager.default.displayName(atPath: currentPath.path)
                )
            )
        }

        return GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    Spacer().frame(width: 0)
                    ForEach(0 ..< parts.count) { index in
                        PathBarItem(
                            image: parts[index].image,
                            name: parts[index].name,
                            arrow: index + 1 != parts.count,
                            height: geometry.size.height
                        )
                    }
                    Spacer().frame(width: 0)
                }
            }
            .onNSView(added: {nsview in
                let root = nsview.subviews[0] as! NSScrollView
                root.horizontalScroller = InvisibleScroller()
                root.documentView?.scroll(.init(x: root.documentView?.frame.width ?? 0, y: 0))
            })
        }
    }
}

struct PathBar_Previews: PreviewProvider {
    static let sizes: [CGFloat] = Array(stride(from: 100, to: 800, by: 50))
    static var previews: some View {
        VStack {
            ForEach(0 ..< sizes.count) { index in
                PathBar(path: "/Users/menushkaweeratunga/Documents")
                    .frame(width: sizes[Int(index)])
                    .frame(height: 20)
                    .background(Color.black)
                
            }
        }
    }
}
