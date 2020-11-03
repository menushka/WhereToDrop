//
//  PathBar.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-11-01.
//

import SwiftUI

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

        return HStack(spacing: 0) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(0 ..< parts.count) { index in
                        HStack(spacing: 0) {
                            Image(nsImage: parts[index].image)
                                .resizable()
                                .frame(width: geometry.size.height, height: geometry.size.height)
                                .padding(.horizontal, 10)
                            Text(parts[index].name)
                                .font(.system(size: geometry.size.height / 2))
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(minWidth: 0)
                                .padding(.trailing, 10)
                            if index + 1 != parts.count {
                                Arrow()
                                    .frame(width: geometry.size.height / 5, height: geometry.size.height / 5)
                            }
                        }
                        .layoutPriority(Double(index))
                        .frame(minWidth: 0)
                    }
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

struct PathBar_Previews: PreviewProvider {
    static let sizes: [CGFloat] = [100, 200, 300, 400, 500, 600]
    static var previews: some View {
        VStack {
            ForEach(0 ..< sizes.count) { index in
                PathBar(path: "/Users/menushkaweeratunga/Documents")
                    .frame(width: sizes[Int(index)])
                    .frame(height: 20)
                    .background(Color.red)
                
            }
        }
    }
}
