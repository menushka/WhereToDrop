//
//  MainViewModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-15.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject, Identifiable {

    @Published var state: MainViewModelState
    @Published var settings: Settings?

    let appleScriptModel = AppleScriptModel()
    let bashModel = BashModel()
    let settingsModel = SettingsModel()

    init() {
        guard let loadedSettings = try? settingsModel.load() else {
            state = .notInstalled
            settings = nil
            return
        }
        state = .installed
        settings = loadedSettings
    }
    
    func setState(state: MainViewModelState) {
        if (Thread.isMainThread) {
            self.state = state
        } else {
            DispatchQueue.main.async {
                self.state = state
            }
        }
    }

    func setRedirectPath() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose path to send AirDrop files to..."
        dialog.showsHiddenFiles = true
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                let path = result!.path
                do {
                    try changeSettings { settings in
                        Settings(enabled: settings!.enabled, path: path)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }

    func installScript() {
        self.setState(state: .installing)
        DispatchQueue.global(qos: .background).async {
            do {
                try self.bashModel.copySorter()
                try self.appleScriptModel.runAttach()
                try self.changeSettings { _ in Settings.defaultSettings }

                self.setState(state: .installed)
            } catch let error {
                print(error)
                self.setState(state: .notInstalled)
            }
        }
    }

    func uninstallScript() {
        self.setState(state: .installing)
        DispatchQueue.global(qos: .background).async {
            do {
                try self.settingsModel.clear()
                try self.appleScriptModel.runDetach()
                try self.bashModel.removeSorter()

                self.setState(state: .notInstalled)
            } catch let error {
                print(error)
                self.setState(state: .installed)
            }
        }
    }

    func enableRedirect() {
        do {
            try changeSettings { settings in
                Settings(enabled: true, path: settings!.path)
            }
        } catch {
            print(error)
        }
    }

    func disableRedirect() {
        do {
            try changeSettings { settings in
                Settings(enabled: false, path: settings!.path)
            }
        } catch {
            print(error)
        }
    }
    
    private func changeSettings(_ callback: (Settings?) -> (Settings)) throws {
        let newSettings = callback(self.settings);
        try settingsModel.save(settings: newSettings)
        self.settings = newSettings
    }
}

enum MainViewModelState {
    case notInstalled
    case installing
    case installed
}
