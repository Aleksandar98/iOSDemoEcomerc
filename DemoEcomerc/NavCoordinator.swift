//
//  NavCoordinator.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 26.3.24.
//

import Foundation
import SwiftUI

class NavCoordinator: ObservableObject{
    
    @Published var path = NavigationPath()
    
    func navigateTo(route:Route){
        path.append(route)
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
}

enum Route: Hashable{
    case Home
    case Detail(Product)
    case ProductList(String)
    case Cart
    case Profile
    case PreviousOrders(Int)
}
