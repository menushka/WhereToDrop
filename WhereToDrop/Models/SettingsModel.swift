//
//  SettingsModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-21.
//

import Foundation

class SettingsModel {
    private static let SETTINGS_FILENAME = "app.settings"
    private static let SETTINGS_ENCODING = String.Encoding.utf8

    func load() throws -> Settings {
        let settingsPath = try getSettingsPathInApplicationSupport()
        do {
            let settingsContent = try String(contentsOf: settingsPath, encoding: Self.SETTINGS_ENCODING)
            return Settings(string: settingsContent)
        } catch let error {
            print(error)
            throw SettingsError.settingsParseFailed
        }
    }

    func save(settings: Settings) throws {
        let settingsPath = try getSettingsPathInApplicationSupport()
        do {
            if !FileManager.default.fileExists(atPath: settingsPath.absoluteString) {
                FileManager.default.createFile(atPath: settingsPath.absoluteString, contents: nil, attributes: nil)
            }
            try settings.toString().write(to: settingsPath, atomically: true, encoding: Self.SETTINGS_ENCODING)
        } catch let error {
            print(error)
            throw SettingsError.settingsWriteFailed
        }
    }

    func clear() throws {
        let settingsPath = try getSettingsPathInApplicationSupport()
        do {
            try FileManager.default.removeItem(at: settingsPath)
        } catch let error {
            print(error)
            throw SettingsError.settingsWriteFailed
        }
    }
    
    private func getSettingsPathInApplicationSupport() throws -> URL {
        let appDir = try getApplicationSupportFolder()
        let settingsFilePath = appDir.appendingPathComponent(Self.SETTINGS_FILENAME)
        return settingsFilePath
    }
    
    private func getApplicationSupportFolder() throws -> URL {
        guard let applicationSupportDir = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            throw SettingsError.settingsPathNotFound
        }
        let appDir = applicationSupportDir.appendingPathComponent(getApplicationName())
        if !FileManager.default.fileExists(atPath: appDir.absoluteString) {
            guard ((try? FileManager.default.createDirectory(at: appDir, withIntermediateDirectories: true)) != nil) else {
                throw SettingsError.settingsPathNotCreated
            }
        }
        return appDir
    }
    
    private func getApplicationName() -> String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    }
}

enum SettingsError: Error {
    case settingsPathNotFound
    case settingsPathNotCreated
    case settingsParseFailed
    case settingsWriteFailed
}
