//
//  User.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import Foundation

struct User:Identifiable,Codable{
    let id:Int
    let email:String
    let username:String
    let password:String
    let name:Name
    let address:Address
    let phone:String
}

struct Name:Codable {
    let firstname:String
    let lastname:String
}

struct Address:Codable {
    let city:String
    let street:String
    let number:Int
}
