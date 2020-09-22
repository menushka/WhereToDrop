//
//  MainViewModel.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-09-15.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject, Identifiable {

    @Published var savedRedirectPath: String = ""

    let appleScriptModel = AppleScriptModel()
    let bashModel = BashModel()

    func setRedirectPath() {
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
                savedRedirectPath = path
            }
        }
    }

    func startRedirect() {
        do {
            try bashModel.copySorter(redirectPath: self.savedRedirectPath)
            try appleScriptModel.runAttach()
        } catch let error {
            print(error)
        }
    }

    func stopRedirect() {
        do {
            try appleScriptModel.runDetach()
            try bashModel.removeSorter()
        } catch let error {
            print(error)
        }
    }
}
