//
//  NotInstalledMainView.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-12.
//

import SwiftUI

struct NotInstalledMainView: View {
    
    @EnvironmentObject var viewModal: MainViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Button("Install", action: viewModal.installScript)
                .frame(maxWidth: .infinity)
            Spacer()
        }
        .padding()
    }
}

struct NotInstalledMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotInstalledMainView()
                .modifier(PreviewMode(scheme: .light, width: 350, height: 350))
            NotInstalledMainView()
                .modifier(PreviewMode(scheme: .dark, width: 350, height: 350))
            
        }
        .environmentObject(MainViewModel())
    }
}
