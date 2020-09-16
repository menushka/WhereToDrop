//
//  HelperScripts.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-08-30.
//  Copyright © 2020 Menushka Weeratunga. All rights reserved.
//

import Foundation

class HelperScripts {
    private static let SORTER_TEMPLATE_FILENAME: String = "AirDropSorter"
    private static let ATTACH_SCRIPT_FILENAME: String = "AttachFolderActionScript"
    private static let REMOVE_SCRIPT_FILENAME: String = "DetachFolderActionScript"

    static func runAttachFolderActionScript() throws {
        guard let path = getBundlePath(fileName: ATTACH_SCRIPT_FILENAME) else {
            throw AirDropSorterError.bundlePathFailed
        }
        let contents = try String(contentsOfFile: path)
        try contents.runApplescript()
    }

    static func runDetachFolderActionScript() throws {
        guard let path = getBundlePath(fileName: REMOVE_SCRIPT_FILENAME) else {
           throw AirDropSorterError.bundlePathFailed
       }
       let contents = try String(contentsOfFile: path)
       try contents.runApplescript()
    }

    private static func getBundlePath(fileName: String) -> String? {
        return Bundle.main.path(forResource: fileName, ofType: "scpt")
    }
}
