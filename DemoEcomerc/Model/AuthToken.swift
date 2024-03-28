//
//  Token.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 19.3.24.
//

import Foundation
import SwiftData

@Model
class AuthToken{
    var authToken:String
    
    init(authToken: String) {
        self.authToken = authToken
    }
}
