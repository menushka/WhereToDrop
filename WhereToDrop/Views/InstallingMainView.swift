//
//  InstallingMainView.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-12.
//

import SwiftUI

struct InstallingMainView: View {
    
    @EnvironmentObject var viewModal: MainViewModel

    var body: some View {
        VStack {
            Spacer()
            WTDSpinner()
                .frame(height: 50)
            Spacer()
        }
        .padding()
    }
}

struct InstallingMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InstallingMainView()
                .modifier(PreviewMode(scheme: .light, width: 350, height: 350))
            InstallingMainView()
                .modifier(PreviewMode(scheme: .dark, width: 350, height: 350))
            
        }
        .environmentObject(MainViewModel())
    }
}
