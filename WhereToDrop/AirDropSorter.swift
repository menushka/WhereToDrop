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

    func start(path: String) {
        self.currentPath = path
        
        do {
            try self.addScriptToPath(path: path)
        } catch let error {
            print("Something went wrong: ", error.localizedDescription)
        }
    }

    func stop() {
        self.currentPath = nil
    }
    
    private func addScriptToPath(path: String) throws {
        let folderActionScriptsPath = NSString.path(withComponents: ["/", "Library", "Scripts", "Folder Action Scripts"])
        let sorterPath = NSString.path(withComponents: [folderActionScriptsPath, AirDropSorter.AIRDROP_SORTER_FILE_NAME])
        let bundlePath = Bundle.main.path(forResource: "AirDropSorter", ofType: "scpt")
        
        if FileManager.default.fileExists(atPath: sorterPath) {
            throw AirDropSorterError.fileExistsAlready
        }
        try FileManager.default.copyItem(at: URL(fileURLWithPath: bundlePath!), to: URL(fileURLWithPath: sorterPath))
    }
}

enum AirDropSorterError: Error {
    case fileExistsAlready
}
