//
//  AuthService.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 10.3.24.
//

import Foundation

class AuthService{
    
    func loginUser(credentials:Credentials) async throws -> String? {
        
        let endpoint = "https://fakestoreapi.com/auth/login"
        
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        let data = try encoder.encode(credentials)
        request.httpBody = data

        let (responseData, response) = try await URLSession.shared.upload(for: request, from: data)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AuthError.invalidResponse
        }
        
        let result = try JSONDecoder().decode([String:String].self, from: responseData)
        
        return result["token"]
        
    }
}
