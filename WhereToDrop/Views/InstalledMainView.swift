//
//  InstalledMainView.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-10-11.
//

import SwiftUI

struct InstalledMainView: View {
    
    @EnvironmentObject var viewModal: MainViewModel

    var body: some View {
        let currentRedirectPath = viewModal.settings!.path
        let isEnabled = viewModal.settings!.enabled
        
        return GeometryReader { _ in
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    Text("Redirection path:")
                        .font(.system(size: 14))
                    VStack(spacing: 5) {
                        PathBar(path: currentRedirectPath)
                            .frame(maxWidth: .infinity)
                            .frame(height: 18)
//                        TextField("", text: .constant(currentRedirectPath))
//                            .font(.system(size: 14))
                        HStack(alignment: .top) {
                            Text("Path on your local computer to transfer AirDrop files to.")
                                .font(.system(size: 10))
                                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button("Select...", action: viewModal.setRedirectPath)
                                .font(.system(size: 14))
                        }
                    }
                }
                
                Divider()
                    .padding(.vertical, 10)

                VStack(alignment: .leading) {
                    HStack {
                        WTDStatusIcon(active: isEnabled)
                            .frame(width: 9, height: 9)
                        Text("Redirecting: \(isEnabled ? "On" : "Off")")
                            .font(.system(size: 12))
                        Spacer()
                    }
                    Text("WhereToDrop will automatically transfer files from the default AirDrop location to the new location specificed above.")
                        .font(.system(size: 10))
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    HStack {
                        Spacer()
                        Button(
                            isEnabled ? "Disable" : "Enable",
                            action: isEnabled ? viewModal.disableRedirect : viewModal.enableRedirect
                        )
                        .font(.system(size: 14))
                    }
                }
                
                Divider()
                    .padding(.vertical, 10)

                HStack {
                    Text("Uninstall WhereToDrop files: remove settings file and deattach and remove folder action script file.")
                        .font(.system(size: 10))
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button("Uninstall", action: viewModal.uninstallScript)
                        .font(.system(size: 14))
                }
            }
            .padding()
        }
    }
}

struct InstalledMainView_Previews: PreviewProvider {
    static var width: CGFloat = 650
    static var height: CGFloat = 350
    static var previews: some View {
        Group {
            InstalledMainView()
                .modifier(PreviewMode(scheme: .light, width: width, height: height))
            InstalledMainView()
                .modifier(PreviewMode(scheme: .dark, width: width, height: height))
            
        }
        .environmentObject(MainViewModel())
    }
}
