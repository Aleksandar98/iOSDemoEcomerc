//
//  Product.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 10.3.24.
//

import Foundation
import SwiftData

struct ProductDto: Codable,Identifiable,Hashable {
    
    let id:Int
    let title:String
    let price:Double
    let category:String
    let description:String
    let image:String
}

@Model
class Product {
    let id:Int
    let title:String
    let price:Double
    let category:String
    let productDesc:String
    let image:String
    
    var productVariants:[String:[String]]
    
    init(id: Int, title: String, price: Double, category: String, productDesc: String, image: String, productVariants: [String : [String]]) {
        self.id = id
        self.title = title
        self.price = price
        self.category = category
        self.productDesc = productDesc
        self.image = image
        self.productVariants = productVariants
    }
}
