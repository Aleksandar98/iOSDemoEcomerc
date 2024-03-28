//
//  ProductListViewModel.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 20.3.24.
//

import Foundation

@Observable
class ProductListViewModel{
    
    var productList:[Product] = []
    
    func fetchProductsForCategory(category:String) async throws{
        var endpoint = "https://fakestoreapi.com/products/category/\(category)"
        if(category == "all"){
            endpoint = "https://fakestoreapi.com/products"
        }
        
        guard let url = URL(string: endpoint) else {throw ProductFetchError.InvalidUrlError }
        
        let (data,response) = try await URLSession.shared.data(from:url)
        
        guard let responseData = response as? HTTPURLResponse, responseData.statusCode == 200 else {
            throw ProductFetchError.FetchError
        }
        
        let parsedResponseData = try JSONDecoder().decode([ProductDto].self, from: data)
        
        print(parsedResponseData)
        
        productList = parsedResponseData.map{productDto in Product(id: productDto.id, title: productDto.title, price: productDto.price, category: productDto.category, productDesc: productDto.description, image: productDto.image, productVariants: ["Size":["S","M","L"]])}
        
    }
}
