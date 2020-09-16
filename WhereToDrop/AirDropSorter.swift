//
//  AirDropManager.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-08-19.
//  Copyright © 2020 Menushka Weeratunga. All rights reserved.
//

import Foundation
import AppKit

class AirDropSorter {

    private static let AIRDROP_SORTER_FILE_NAME: String = "AirDropSorter.scpt"

    private var currentPath: String?

    func pickPath() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose path to send AirDrop files to..."
        dialog.showsHiddenFiles = true
        dialog.allowsMultipleSelection = true
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                let path = result!.path
                currentPath = path
            }
        }
    }

    func start() {
        guard let path = currentPath else { return }

        do {
            try self.addScript(redirectPath: path)
            try HelperScripts.runAttachFolderActionScript()
        } catch RunError.executeFailed(error: let error) {
            print(error["NSAppleScriptErrorBriefMessage"])
        } catch let error {
            print("Unknown error during start \(error)")
        }
    }

    func stop() {
        do {
            try HelperScripts.runDetachFolderActionScript()
            try self.removeScript()
        } catch let e {
            print("Unknown error during start \(e)")
        }
    }

    private func generateConvertToAliasCommand(path: String) -> String {
        return "return POSIX file \"\(path)\" as alias as string"
    }

    private func generateCopyActionScriptCommand(bundlePath: String, redirectPath: String, actionItemsPath: String) -> String {
        return "cat \(bundlePath) | sed 's/Path:to:AirDrop:Folder:in:Alias:format/\(redirectPath)/g' > \(actionItemsPath)"
    }

    private func addScript(redirectPath: String) throws {
        let command = generateConvertToAliasCommand(path: redirectPath)
        guard let aliasPath = try? command.runApplescript() else {
            throw AirDropSorterError.aliasConversionFailed
        }

        let sorterPath = getPathToSorterScript()
        guard let bundlePath = Bundle.main.path(forResource: "AirDropSorter", ofType: "scpt") else {
            throw AirDropSorterError.bundlePathFailed
        }

        let copyCommand = "sudo cat '\(bundlePath)' | sed 's/Path:to:AirDrop:Folder:in:Alias:format/\(aliasPath)/g' > '\(sorterPath)'"
        try copyCommand.runSudo()
    }
    
    private func removeScript() throws {
        let sorterPath = getPathToSorterScript()
        let removeCommand = "rm '\(sorterPath)'"
        try removeCommand.runSudo()
    }
    
    private func getPathToSorterScript() -> String {
        let folderActionScriptsPath = NSString.path(withComponents: ["/", "Library", "Scripts", "Folder Action Scripts"])
        let sorterPath = NSString.path(withComponents: [folderActionScriptsPath, AirDropSorter.AIRDROP_SORTER_FILE_NAME])
        return sorterPath
    }
}

enum AirDropSorterError: Error {
    case aliasConversionFailed
    case bundlePathFailed
}
