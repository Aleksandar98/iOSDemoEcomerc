//
//  AuthError.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 11.3.24.
//

import Foundation

enum AuthError : Error {
    case invalidUrl
    case invalidResponse
    case errorParsing
    
}
