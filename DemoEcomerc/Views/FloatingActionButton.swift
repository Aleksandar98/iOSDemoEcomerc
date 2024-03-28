//
//  FloatingActionButton.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 15.3.24.
//

import SwiftUI

struct FloatingActionButton: View {
    var systemImageName:String = "minus"
    
    var body: some View {
        ZStack{
            Image(systemName: systemImageName).resizable().aspectRatio(contentMode: .fit).frame(width: 15,height: 15).foregroundColor(.gray).padding(15).background(.white).clipShape(Circle())
        }.shadow(color: Color(.gray).opacity(0.4), radius: 5, x: 3, y: 3)
    }
}

#Preview {
    FloatingActionButton()
}
