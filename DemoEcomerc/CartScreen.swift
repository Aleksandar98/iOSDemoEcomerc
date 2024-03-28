//
//  CartScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import SwiftUI
import SwiftData
struct CartScreen: View {
    
    @StateObject var viewModel = CartViewModel()
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    @Query var productsInCart:[Product]
    
    @State var isCheckoutClicked:Bool = false
    @State var totalAmount:Double = 0
    
    var body: some View {
        if productsInCart.isEmpty {
            ContentUnavailableView(label: {
                Label("No items in the cart", systemImage:"list.bullet.rectangle.portrait")
            }, description: {
                Text("Add item to your cart")
            }, actions: {
                Button("Add item"){
                    navCoordinator.navigateTo(route: Route.ProductList("all"))
                }
            })
        }else{
            VStack{
                Text("My Bag").font(.system(size: 30,weight: .bold))
                
                ScrollView{
                    LazyVStack{
                        ForEach(productsInCart){product in
                            CartProductListItem(product: product,totalAmount:$totalAmount)
                        }
                    }
                }
                
                HStack{
                    Text("Total amount:")
                    Spacer()
                    Text(String(format:"$%.2f",totalAmount)).fontWeight(.bold)
                }.padding()
                
                AccentButton(text: "Check out") {
                    viewModel.checkOut(userId:0,products:productsInCart)
                    isCheckoutClicked.toggle()
                }.padding()
            }
            .onAppear(perform: {
                totalAmount = productsInCart.map({product in product.price}).reduce(0, +)
            })
            .sheet(isPresented: $isCheckoutClicked, content: {
                VStack{
                    Spacer()
                    Image("bags")
                    Text("Success!").font(.system(size: 30,weight: .bold))
                    Text("Your order will be delivered soon \n Thank you for choosing our app")
                    Spacer()
                    AccentButton(text: "Continue shooping", onClick: {
                        navCoordinator.navigateTo(route: Route.ProductList("all"))
                    }).padding()
                }
            })
        }
        
        
        
    }
}

struct CartProductListItem: View {
    
    @Environment(\.modelContext) var context
    
    let product:Product
    
    @Binding var totalAmount:Double
    
    @State var productQuantity:Int = 1
    
    var body: some View {
        HStack{
            AsyncImage(
                url: URL(string:product.image),
                content: { phase in
                    
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fit).frame(width: 100,height: 100)
                    } else if phase.error != nil {
                        //Image("category_gallery_item_img") // Indicates an error, show default image
                    } else {
                        // Acts as a placeholder.
                        //Image("category_gallery_item_img")
                        ProgressView().progressViewStyle(.circular)
                        // Image("Mickey Mouse")
                    }
                }
            )
            VStack{
                HStack{
                    VStack(alignment:.leading){
                        Text(product.title).font(.system(size: 18,weight: .semibold))
                        HStack{
                            ForEach(Array(product.productVariants.keys),id:\.self){ key in
                                HStack(spacing: 3){
                                    Text("\(key):").font(.system(size: 13)).foregroundColor(.gray)
                                    Text("\((product.productVariants[key]?.first)!)").font(.system(size: 13))
                                }
                            }


                            
                        }
                    }
                    Spacer()
                    Image(systemName: "ellipsis").rotationEffect(.degrees(90)).frame(alignment: .topLeading)
                }
                Spacer().frame(height:30)
                HStack{
                    FloatingActionButton(systemImageName: "minus").onTapGesture{
                        productQuantity -= 1
                        totalAmount -= product.price
                        if(productQuantity == 0){
                            context.delete(product)
                        }
                    }
                    
                    Text("\(productQuantity)").padding(5)
                    
                    FloatingActionButton(systemImageName: "plus").onTapGesture {
                        totalAmount += product.price
                        productQuantity += 1
                    }
                    Spacer()
                    Text(String(format:"$%.2f",product.price))
                }
            }.padding(5)
        }.cornerRadius(15).padding(5)
    }
}

#Preview {
    CartScreen()
}
