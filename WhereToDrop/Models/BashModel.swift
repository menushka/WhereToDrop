//
//  BashModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-15.
//

import Foundation

class BashModel {
    private static let SORTER_TEMPLATE_SCRIPT_FILENAME = "AirDropSorter"

    func copySorter(redirectPath: String) throws {
        let scriptPath = getScriptPathInFolderActionScripts()
        let applescript = AppleScript(bundleFileName: Self.SORTER_TEMPLATE_SCRIPT_FILENAME)
        guard let path = applescript.path else { throw BashModelError.pathNotFound }

        let copyCommand = "cat '\(path)' > '\(scriptPath)'"
        try copyCommand.runSudo()
    }

    func removeSorter() throws {
        let scriptPath = getScriptPathInFolderActionScripts()
        let removeCommand = "rm '\(scriptPath)'"
        try removeCommand.runSudo()
    }

    private func getScriptPathInFolderActionScripts() -> String {
        let folderActionScriptsPath = NSString.path(withComponents: ["/", "Library", "Scripts", "Folder Action Scripts"])
        let sorterPath = NSString.path(withComponents: [folderActionScriptsPath, "\(Self.SORTER_TEMPLATE_SCRIPT_FILENAME).scpt"])
        return sorterPath
    }
}

enum BashModelError: Error {
    case pathNotFound
}
