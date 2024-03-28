//
//  HomeScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 11.3.24.
//

import SwiftUI

struct HomeScreen: View {
    
    let viewModel = HomeViewModel()
    
    
    
    var body: some View {
        
        TabView{
            HomeView(categoriesWithProducts:viewModel.categoryWithProducts)
                .tabItem {
                    Label("Home",systemImage: "house")
                }
            CartScreen()
                .tabItem {
                    Label("Cart",systemImage: "cart")
                }
            ProfileScreen()
                .tabItem {
                    Label("Profile",systemImage: "person.crop.circle")
                }
        }
    }
}



struct HomeView: View {
    
    let categoriesWithProducts:[String:[Product]]
    
    var body: some View {
        
            ScrollView(){
                BannerView()
                LazyVStack{
                    ForEach(Array(categoriesWithProducts.keys), id: \.self){category in
                        CategoryItem(category:category, products: categoriesWithProducts[category] ?? [])
                    }
                }
                
            }
            .ignoresSafeArea()
    }
}


struct CategoryItem: View {
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    
    let category:String
    let products:[Product]
    
    var body: some View {
        VStack{
            CategoryItemHeader(title:category,description: "Super summer sale")
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(products) { product in
                        ProductGridItem(product:product)
                            .onTapGesture {
                                navCoordinator.navigateTo(route: Route.Detail(product))
                            }
                    }
                }
            }
        }
    }
}


struct CategoryItemHeader: View {
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    let title:String
    let description:String
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(title).font(.title).fontWeight(.bold).autocapitalization(.words)
                Text(description).font(.caption).foregroundColor(.gray)
            }
            Spacer()
            Text("View all").font(.system(size: 12)).onTapGesture {
                navCoordinator.navigateTo(route: Route.ProductList(title))
            }
        }.padding()
        
    }
}

struct BannerView: View{
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    var body: some View{
        ZStack(alignment:.bottomLeading){
            Image("banner_img")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading,spacing: 3.0){
                Text("Fashion \nSale")
                    .font(.system(size: 40).weight(.black))
                    .foregroundColor(.white)
                    .lineSpacing(0.5)
                Button("Check"){
                    navCoordinator.navigateTo(route: Route.ProductList("all"))
                }
                .padding(10)
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }.padding()
        }
    }
}

#Preview {
    HomeScreen()
}
