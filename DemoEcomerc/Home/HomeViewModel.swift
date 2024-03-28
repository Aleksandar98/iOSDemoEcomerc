//
//  HomeViewModel.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 11.3.24.
//

import Foundation

@Observable
class HomeViewModel{
    
    var categoryWithProducts:[String:[Product]] = [:]
    
    let catagorieService = CategoriesService()
    
    init(){
        Task{
            await test()
        }
    }
    
    
    
//    func fetchProductsForCategoryWithLimit(category:String){
//            do{
//                try await catagorieService.getProductsForCategoryWithLimit(category: category)
//            }catch{
//                print(error)
//            }
//    }
    
    func test() async {
        do{
            var _categoryWithProducts:[String:[Product]] = [:]
            let categories = try await catagorieService.fetchAllCategories()
            
            for category in categories{
                let products = try await catagorieService.getProductsForCategoryWithLimit(category: category)
                
                _categoryWithProducts[category] = products
                print(products)
                print("------------")
            }
            
            self.categoryWithProducts = _categoryWithProducts

            
        }catch{
            print(error)
        }
    }
    
//    func fetchCategories() async ->[String]{
//        return async Task{ () -> [String] in
//            do{
//                return try await catagorieService.fetchAllCategories()
//            }catch{
//                print(error)
//                return []
//            }
//        }.result.get()
//        
//    }
}
