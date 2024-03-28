//
//  LoginScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 11.3.24.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.modelContext) var context
    
    @State var email:String = ""
    @State var password:String = ""
    
    @State var viewModel = LoginViewModel()
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    var body: some View {
        VStack {
            Text("Demo E Comerc")
                .font(.custom("AmericanTypewriter", size: 40).weight(.bold))
                .foregroundColor(.red)
            
            Spacer().frame(height:100)
            
            Text("Login").font(.system(size: 30))
            
            CustomTextField(text: $email, placeholder: "Email")
            CustomTextField(text: $password, placeholder: "Password")
            Spacer().frame(height: 20)
            HStack{
                Text("Forgot password?")
            }
            .frame(maxWidth: .infinity ,alignment: .trailing)
            
            Spacer().frame(height: 50)
            
            Button("Login") {
                viewModel.loginUser(email: email, pass: password){
                    navCoordinator.navigateTo(route: Route.Home)
                }
            }
            
            
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            
            
        }
        .alert(viewModel.alertMessage,isPresented: $viewModel.showAlert ){
            Button("OK", role: .cancel) { }
        }
        .padding()
        .onAppear(perform: {
            viewModel.modelContext = context
        })
    }
    
}

#Preview {
    LoginScreen()
}
