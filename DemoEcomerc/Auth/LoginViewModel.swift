//
//  LoginViewModel.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 10.3.24.
//

import Foundation
import SwiftData

@Observable
class LoginViewModel{
    
    var modelContext:ModelContext? = nil
    
    let authService = AuthService()
    
    var showAlert:Bool = false
    
    var alertMessage:String = ""
    
    func loginUser(email:String, pass:String, onLoginSuccessful:@escaping()->Void){
        Task{
            do{
                //TODO don't publish from background thread
                let token = try await authService.loginUser(credentials:Credentials(username: email, password: pass))
                modelContext?.insert(AuthToken(authToken: token!))
                if(!token!.isEmpty){
                    onLoginSuccessful()
                }
                
                
            }catch{
                //TODO show alert with error
                alertMessage = error.localizedDescription
                showAlert = true
                print(error)
            }
        }
    }
}
