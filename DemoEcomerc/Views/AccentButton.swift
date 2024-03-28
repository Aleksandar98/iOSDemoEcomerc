//
//  AccentButton.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 15.3.24.
//

import SwiftUI

struct AccentButton: View {
    
    var text:String
    var onClick:()->Void
    
    var body: some View {
        Button(text) {
            onClick()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.red)
        .foregroundColor(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    AccentButton(text:"Add to cart"){}
}
