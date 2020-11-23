//
//  AppleScript.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-20.
//

import Foundation

struct AppleScript {
    
    private static let APPLESCRIPT_EXT = "scpt"

    var script: String? = nil
    var path: String? = nil

    init(script: String) {
        self.script = script
        self.path = nil
    }

    init(bundleFileName: String) {
        guard let path = Bundle.main.path(forResource: bundleFileName, ofType: Self.APPLESCRIPT_EXT) else { return }
        guard let content = try? String(contentsOfFile: path) else { return }
        self.script = content
        self.path = path
    }

    func run() throws {
        if let rawScript = self.script {
            try rawScript.runApplescript()
        } else {
            throw AppleScriptError.noScript
        }
    }
}

enum AppleScriptError: Error {
    case noScript
}
