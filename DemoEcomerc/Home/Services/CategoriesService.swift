//
//  CategoriesService.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import Foundation
class CategoriesService{
    
    func fetchAllCategories() async throws -> [String]{
        let endpoint = "https://fakestoreapi.com/products/categories"
        
        guard let url = URL(string: endpoint) else {throw ProductFetchError.InvalidUrlError }
        
        let (data,response) = try await URLSession.shared.data(from:url)
        
        guard let responseData = response as? HTTPURLResponse, responseData.statusCode == 200 else {
            throw ProductFetchError.FetchError
        }
        
        let parsedResponseData = try JSONDecoder().decode([String].self, from: data)
        
        print(parsedResponseData)
        
        return parsedResponseData
       
    }
    
    func getProductsForCategoryWithLimit(category:String,limit:Int = 5) async throws -> [Product]{
        
        let endpoint = "https://fakestoreapi.com/products/category/\(category)?limit=\(limit)"
        
        guard let url = URL(string: endpoint) else {throw ProductFetchError.InvalidUrlError }
        
        let (data,response) = try await URLSession.shared.data(from:url)
                
        guard let responseData = response as? HTTPURLResponse, responseData.statusCode == 200 else {
            throw ProductFetchError.FetchError
        }
        
        let parsedResponseData = try JSONDecoder().decode([ProductDto].self, from: data)
        
        return parsedResponseData.map{productDto in Product(
            id: productDto.id,
            title: productDto.title,
            price: productDto.price,
            category: productDto.category,
            productDesc: productDto.description,
            image: productDto.image,
            productVariants: ["Size" : ["S","M"]])
        }
        
    }
    
//    func getAllProductsForCategory(category:String) async throws -> [Product]{
//        
//    }
//    
//    func getProductDetail(productId:Int) async throws -> Product{
//        
//    }
}
