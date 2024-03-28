//
//  CartListScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 18.3.24.
//

import SwiftUI

struct CartListScreen: View {
    
    var userId:Int
    
    var viewModel = CartListViewModel()
    
    var body: some View {
        VStack{
            Text("My Orders").font(.system(size: 35)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            LazyVStack{
                ForEach(viewModel.allCartsForUser){ cartItem in
                    CartListItem(cart: cartItem)
                }
            }
            
        }.onAppear(perform: {
            Task{
                do{
                    try await viewModel.fetchAllOrdersForUser(userId: userId)
                }catch{
                    print(error)
                }
            }
        })
    }
}

#Preview {
    CartListScreen(userId: 0)
}

struct CartListItem:View {
    
    var cart:Cart
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text("Order N \(cart.id)").font(.system(size: 17,weight: .semibold))
                Spacer()
                Text(cart.date).font(.system(size: 14)).foregroundColor(.gray)
            }.padding(7)
            HStack{
                Text("Tracking number:").font(.system(size: 14)).foregroundColor(.gray)
                Text(cart.trackingNumber).font(.system(size: 14,weight: .semibold))
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 2, trailing: 5))
            
            HStack{
                Text("Quantity:").font(.system(size: 14)).foregroundColor(.gray)
                Text("\(cart.quantity)").font(.system(size: 14,weight: .semibold))
                
                Spacer()
                
                Text("Total amount:").font(.system(size: 14)).foregroundColor(.gray)
                Text("\(cart.totalAmount)").font(.system(size: 14,weight: .semibold))
                
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 2, trailing: 5))
            HStack{
                Button("Details"){
                    
                }.padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25)).background(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    ).stroke(Color(.black)))
                
                Spacer()
                
                Text( cart.orderStatus).font(.system(size: 14)).foregroundColor(.green)
            }.padding(7)
        }.padding(10).background(.white).cornerRadius(10).frame(maxWidth: 350)
    }
}
