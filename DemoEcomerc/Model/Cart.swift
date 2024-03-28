//
//  Cart.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 10.3.24.
//

import Foundation

struct Cart:Identifiable{
    var id:Int
    var userId:Int
    var date:String
    var products:[Product]
    
    var trackingNumber:String
    var totalAmount:Double
    var orderStatus:String
    var quantity:Int
}

struct CartDto:Decodable{
    var id:Int
    var userId:Int
    var date:String
    var products:[ProductInCartDto]
}

struct ProductInCartDto:Decodable{
    var productId:Int
    var quantity:Int
}
