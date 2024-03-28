//
//  ProfileViewModle.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import Foundation

@Observable
class ProfileViewModel{
    
    var user:User?
    
    init(){
        Task{
            do{
                try await fetchUserData(id:1)
            }catch{
                print(error)
            }
        }
    }
    
    private func fetchUserData(id:Int) async throws{
        let endpoint = "https://fakestoreapi.com/users/\(id)"
        
        guard let url = URL(string: endpoint) else {throw UserFetchError.InvalidUrlError}
        
        let (data,response) = try await URLSession.shared.data(from:url)
        
        guard let responseData = response as? HTTPURLResponse, responseData.statusCode == 200 else {
            throw UserFetchError.FetchError
        }
        
        let parsedResponseData = try JSONDecoder().decode(User.self, from: data)
        
        print(parsedResponseData)
        
        user = parsedResponseData
    }
    
    func deleteUser(){
        Task{
            do{
                let endpoint = "https://fakestoreapi.com/users/\(user!.id)"
                
                let url = URL(string: endpoint)!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "DELETE"

                let (responseData, response) = try await URLSession.shared.data(for: request)
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw AuthError.invalidResponse
                }
                
                print(response)
            }catch{
                
            }
        }

    
    }

}

enum UserFetchError:Error{
    case InvalidUrlError
    case FetchError
    case ParseError
}
