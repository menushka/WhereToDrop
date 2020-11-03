//
//  Settings.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-21.
//

import Yams

struct Settings: Codable {
    static let EMPTY: String = ""
    var enabled: Bool
    var path: String
}

extension Settings {
    static var defaultSettings: Settings {
        Settings(enabled: false, path: "")
    }
}

extension Settings {
    init(string: String) {
        do {
            let decoded = try YAMLDecoder().decode(Settings.self, from: string)
            self.enabled = decoded.enabled
            self.path = decoded.path
        } catch {
            self.enabled = false
            self.path = Settings.EMPTY
        }
//        let lines = string.split(whereSeparator: \.isNewline)
//        self.enabled = String(lines[0]).elementsEqual("true")
//        self.path = String(lines[1])
    }
    
    func toString() throws -> String {
        return try YAMLEncoder().encode(self)
    }
}
