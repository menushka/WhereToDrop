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
            GroupBox {
                switch (viewModel.state) {
                case .notInstalled:
                    NotInstalledMainView()
                case .installing:
                    InstallingMainView()
                case .installed:
                    InstalledMainView()
                }
            }
            .environmentObject(viewModel)
            .frame(maxWidth: .infinity)
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.windowBackgroundColor))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(viewModel: MainViewModel())
                .modifier(PreviewMode(scheme: .light, width: AppDelegate.WIDTH, height: AppDelegate.HEIGHT))
            MainView(viewModel: MainViewModel())
                .modifier(PreviewMode(scheme: .dark, width: AppDelegate.WIDTH, height: AppDelegate.HEIGHT))
        }
    }
}
