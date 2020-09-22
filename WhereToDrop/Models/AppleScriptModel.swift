//
//  AppleScriptModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-15.
//

import Foundation

class AppleScriptModel {
    private static let ATTACH_SCRIPT_FILENAME = "AttachFolderActionScript"
    private static let DETACH_SCRIPT_FILENAME = "DetachFolderActionScript"

    func runAttach() throws {
        try AppleScript(bundleFileName: Self.ATTACH_SCRIPT_FILENAME).run()
    }

    func runDetach() throws {
        try AppleScript(bundleFileName: Self.DETACH_SCRIPT_FILENAME).run()
    }
}
