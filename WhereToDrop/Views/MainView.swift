//
//  MainView.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-08-18.
//  Copyright © 2020 Menushka Weeratunga. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("WhereToDrop")
                .font(Font.system(size: 20, weight: .black, design: .default))
                .padding(.top, 40)
                .padding(.bottom, 20)
            switch (viewModel.state) {
            case .notInstalled:
                NotInstalledMainView()
            case .installing:
                InstallingMainView()
            case .installed:
                InstalledMainView(path: $viewModel.savedRedirectPath)
            }
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.windowBackgroundColor))
    }
}

struct NotInstalledMainView: View {
    var body: some View {
        VStack {
            Spacer()
            WTDButton(text: "Install", action: {})
            Spacer()
        }
    }
}

struct InstallingMainView: View {
    var body: some View {
        VStack {
            Spacer()
            WTDSpinner()
                .frame(height: 50)
            Spacer()
        }
    }
}

struct InstalledMainView: View {
    @Binding var path: String

    var body: some View {
        VStack {
            Spacer()
            TextField("Drop path", text: $path)
            WTDButton(text: "Select path...", action: {})
                .padding(.bottom, 30)

            WTDButton(text: "Enable", action: {})
                .padding(.bottom, 30)
            
            WTDButton(text: "Unnstall", action: {})
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(viewModel: MainViewModel())
                .previewLayout(PreviewLayout.fixed(width: 200, height: 300))
                .environment(\.colorScheme, .light)
            MainView(viewModel: MainViewModel())
                .previewLayout(PreviewLayout.fixed(width: 200, height: 300))
                .environment(\.colorScheme, .dark)
        }
    }
}
