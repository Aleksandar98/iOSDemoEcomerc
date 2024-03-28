//
//  DemoEcomercApp.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 10.3.24.
//

import SwiftUI
import SwiftData

@main
struct DemoEcomercApp: App {
    
    @StateObject private var navCoordinator = NavCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navCoordinator.path){
                LoginScreen()
                    .navigationDestination(for: Route.self){route in
                        switch route{
                            case .Home : HomeScreen()
                            case let .Detail(product) : ProductDetailScreen(product: product)
                            case let .ProductList(category) : ProductListScreen(category: category)
                            case .Cart : CartScreen()
                            case .Profile : ProfileScreen()
                            case let .PreviousOrders(userId) : CartListScreen(userId: userId)
                            
                        }
                    }
            }
            .environmentObject(navCoordinator)
        }
        .modelContainer(for: [Product.self,AuthToken.self])
    }
}



