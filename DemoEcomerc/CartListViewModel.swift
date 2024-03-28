//
//  CartListViewModel.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 18.3.24.
//

import Foundation

@Observable
class CartListViewModel{
    
    var allCartsForUser:[Cart] = []

    
    func fetchAllOrdersForUser(userId:Int) async throws{
        
        let endpoint = "https://fakestoreapi.com/carts/user/\(userId)"
        
        guard let url = URL(string: endpoint) else {throw ProductFetchError.InvalidUrlError }
        
        let (data,response) = try await URLSession.shared.data(from:url)
        
        guard let responseData = response as? HTTPURLResponse, responseData.statusCode == 200 else {
            throw ProductFetchError.FetchError
        }
        
        let parsedCartDto:[CartDto] = try JSONDecoder().decode([CartDto].self, from: data)
        
        let mappedCart = parsedCartDto.map{cartDto in
            Cart(
                id: cartDto.id,
                userId: cartDto.userId,
                date: cartDto.date,
                products: [],
                trackingNumber: "13241321",
                totalAmount: 999,
                orderStatus: "Delivered",
                quantity: cartDto.products.map({$0.quantity}).reduce(0, +)
            )
        }
        
        print(mappedCart)
        
        allCartsForUser = mappedCart
    }
}
