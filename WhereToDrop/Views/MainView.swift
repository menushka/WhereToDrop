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
                .padding(.bottom, 32)
            HStack(spacing: 0) {
                TextField("Drop path", text: $viewModel.savedRedirectPath)
                Button(action: {
                    self.viewModel.setRedirectPath()
                }, label: {
                    Text("Select")
                })
            }
            Button(action: {
                self.viewModel.startRedirect()
            }, label: {
                Spacer()
                Text("Start Redirecting")
                Spacer()
            })
            .frame(maxWidth: .infinity)
            Button(action: {
                self.viewModel.stopRedirect()
            }, label: {
                Text("Stop Redirecting")
            })
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
            .previewLayout(PreviewLayout.fixed(width: 200, height: 300))
    }
}
