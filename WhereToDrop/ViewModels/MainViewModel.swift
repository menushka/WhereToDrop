//
//  MainViewModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-15.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject, Identifiable {

    @Published var state: MainViewModelState = .notInstalled
    @Published var savedRedirectPath: String = ""

    let appleScriptModel = AppleScriptModel()
    let bashModel = BashModel()
    let settingsModel = SettingsModel()

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
                savedRedirectPath = path
            }
        }
    }

    func installScript() {
        do {
            try bashModel.copySorter(redirectPath: self.savedRedirectPath)
        } catch let error {
            print(error)
        }
    }

    func uninstallScript() {
        do {
            try bashModel.removeSorter()
        } catch let error {
            print(error)
        }
    }

    func enabledRedirect() {
        do {
            try appleScriptModel.runAttach()
        } catch let error {
            print(error)
        }
    }

    func disabledRedirect() {
        do {
            try appleScriptModel.runDetach()
        } catch let error {
            print(error)
        }
    }
}

enum MainViewModelState {
    case notInstalled
    case installing
    case installed
}
