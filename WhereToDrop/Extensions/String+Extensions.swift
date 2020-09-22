//
//  String+Extensions.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-08-30.
//  Copyright © 2020 Menushka Weeratunga. All rights reserved.
//

import Foundation

extension String {
    @discardableResult
    func runSudo() throws -> String? {
        return try self.runApplescript(script: "do shell script \"\(self)\" with administrator privileges")
    }
    
    @discardableResult
    func runApplescript() throws -> String? {
        return try self.runApplescript(script: self)
    }

    private func runApplescript(script: String) throws -> String? {
        var error: NSDictionary?
        guard let scriptObject = NSAppleScript(source: script) else {
            throw RunError.scriptObjectFailed
        }
        let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error)
        if (error != nil) {
            throw RunError.executeFailed(error: error!)
        }
        return output.stringValue
    }
}

enum RunError: Error {
    case scriptObjectFailed
    case executeFailed(error: NSDictionary)
}
