//
//  ContentView.swift
//  WhereToDrop
//
//  Created by Menushka Weeratunga on 2020-08-18.
//  Copyright © 2020 Menushka Weeratunga. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var dropPath: String
    
    let airDropSorter = AirDropSorter()
    
    var body: some View {
        VStack {
            Text("WhereToDrop")
                .font(Font.system(size: 20, weight: .black, design: .default))
                .padding(.bottom, 32)
            HStack(spacing: 0) {
                TextField("Drop path", text: $dropPath)
                Button(action: {
                    self.airDropSorter.pickPath()
                }, label: {
                    Text("Select")
                })
            }
            Button(action: {
                self.airDropSorter.start()
            }, label: {
                Spacer()
                Text("Start Redirecting")
                Spacer()
            })
            .frame(maxWidth: .infinity)
            Button(action: {
                self.airDropSorter.stop()
            }, label: {
                Text("Stop Redirecting")
            })
        }
        .padding(.all, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dropPath: .constant("dfsdf"))
            .previewLayout(PreviewLayout.fixed(width: 200, height: 300))
    }
}
