//
//  Settings.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-21.
//

struct Settings {
    let enabled: Bool
    let path: String
}

extension Settings {
    init(string: String) {
        let lines = string.split(whereSeparator: \.isNewline)
        self.enabled = String(lines[0]).elementsEqual("true")
        self.path = String(lines[1])
    }
    
    func toString() -> String {
        return """
            \(self.enabled ? "true" : "false")
            \(self.path)
        """;
    }
}
