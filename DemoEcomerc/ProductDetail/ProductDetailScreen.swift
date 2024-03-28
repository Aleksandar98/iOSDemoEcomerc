//
//  ProductDetailScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import SwiftUI
import SlideOverCard

struct ProductDetailScreen: View {
    
    @Environment(\.modelContext) var context
    
    @State var viewModel = ProductDetailViewModel()
    
    var product:Product
    
    @State private var selectedVariant:[String:String] = [:]
    @State private var isCardShown = false
    @State private var showingOptionsFor :String = ""
    
    
    
    var body: some View {
        
        VStack{
            ScrollView{
                AsyncImage(
                    url: URL(string:product.image),
                    content: { phase in
                        
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 500)
                        } else if phase.error != nil {
                            
                        } else {
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                )
                
                VStack{
                    LazyHStack{
                        ForEach(Array(product.productVariants.keys),id:\.self){key in
                            CustomPicker(title: selectedVariant[key] ?? key )
                                .onTapGesture {
                                    showingOptionsFor = key
                                    isCardShown.toggle()
                                }
                        }
                    }
                    HStack(){
                        VStack(alignment:.leading){
                            Text(product.title).font(.system(size: 25,weight: .bold))
                            Text("Short description").font(.system(size: 12)).foregroundColor(.gray)
                        }
                        Spacer()
                        Text(String(format: "$%.2f", product.price)).font(.system(size: 25,weight: .bold))
                    }.padding()
                    
                    Text(product.productDesc).fixedSize(horizontal: false, vertical: true).padding()
                }
            }
            ZStack{
                AccentButton(text: "Add to cart") {
                    product.productVariants = selectedVariant.mapValues({ value in [value]})
                    context.insert(product)
                    print(product)
                    
                }
            }
            .padding()
            .frame(maxHeight:80)
            .background(
                Rectangle()
                    .fill(.white)
                    .shadow(color: Color(.gray).opacity(0.4), radius: 5, x: 0, y: -3)
                
            )
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
        .ignoresSafeArea()
        .slideOverCard(isPresented: $isCardShown){
            OptionsPopupCard(
                productVariant:showingOptionsFor,
                productVariantOptions:product.productVariants[showingOptionsFor] ?? [],
                onOptionSelected:{tapedVariant in
                    selectedVariant = tapedVariant
                    isCardShown.toggle()
                },
                onActionButtonTap:{}
            )
            
        }
    }
    
}
struct OptionsPopupCard: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var productVariant:String
    var productVariantOptions:[String]
    var onOptionSelected: ([String:String])->Void
    var onActionButtonTap: ()->Void
    
    var body: some View {
        VStack{
            Text(productVariant).padding()
            LazyVGrid(columns:columns){
                ForEach(productVariantOptions,id:\.self){option in
                    PopupCardItem(text: option).onTapGesture {
                        onOptionSelected([productVariant:option])
                    }
                }
            }
            Divider()
            Text("Popup info")
            Divider()
            AccentButton(text: "Add to cart") {
                onActionButtonTap()
            }
        }
    }
}

struct PopupCardItem: View {
    var text:String
    var body: some View {
        Text(text).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)).background(.red).cornerRadius(10)
    }
}

struct CustomPicker: View {
    
    let title:String
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Image(systemName: "chevron.down")
        }
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .cornerRadius(12)
        .padding(18)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 5) // inset value should be same as lineWidth in .stroke
                .stroke(.gray, lineWidth: 1)
        )
    }
    
}

#Preview {
    ProductDetailScreen(
        product: Product(
            id:1,
            title: "Title",
            price: 45.00,
            category: "Demo category",
            productDesc: "asda dasd asdasdasdasd asdasdasd asdasdasaaaaaaaaaaa asd  asd as d asd adasdasd asdasdasdasdasdas dasdasdasdasd asdasdasdasd asd sad as dsa daaaaad ",
            image: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
            productVariants: ["Size" : ["S","M"]]
        )
    )
    
}
