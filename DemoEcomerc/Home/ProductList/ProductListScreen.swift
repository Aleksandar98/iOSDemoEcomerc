//
//  ProductListScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 13.3.24.
//

import SwiftUI

struct ProductListScreen: View {
    
    var category:String
    
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    @State var viewModel = ProductListViewModel()
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    init(category:String){
        self.category = category
        print("called")
    }
    
    var body: some View {
            VStack{
                if(viewModel.productList.isEmpty){
                    
                    ProgressView().progressViewStyle(.circular)
                }
                else{
                    TopCategoryBubbles()
                    
                    TopFiltersBar()
                    
                    ScrollView{
                        Text("\(category.capitalized)").font(.system(size: 25,weight: .bold))
                        LazyVGrid(columns: columns){
                            ForEach(viewModel.productList){ product in
                                
                                ProductGridItem(product:product).onTapGesture {
                                    navCoordinator.navigateTo(route: Route.Detail(product))
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Product.self){product in
                ProductDetailScreen(product: product)
            }
            .onAppear{
                Task{
                    do{
                        try await viewModel.fetchProductsForCategory(category: category)
                        
                    }catch{
                        print(error)
                    }
                }
            }
    }
}

struct TopFiltersBar: View {
    var body: some View {
        HStack{
            HStack{
                Label("Filters", systemImage: "line.3.horizontal.decrease")
                Spacer()
            }
            .padding(10)
            .background(.gray)
            .cornerRadius(15)
            
            HStack{
                Label("Price: lowest to high", systemImage: "arrow.up.arrow.down.square")
                    .scaledToFit()
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            .padding(10)
            .background(.gray)
            .cornerRadius(15)
        }.padding(5)
    }
}

struct TopCategoryBubbles:View{
    var body: some View{
        HStack{
            Text("T-Shirts")
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(15)
            
            Text("T-Shirts")
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(15)
            
            Text("T-Shirts")
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(15)
        }
    }
}

//#Preview {
//   // ProductListScreen()
//}
