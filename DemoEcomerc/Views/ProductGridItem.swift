//
//  ProductGridItem.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 13.3.24.
//

import SwiftUI

struct ProductGridItem: View {
    
    let product:Product

    
    var body: some View {
        VStack{
            ZStack{
                AsyncImage(
                    url: URL(string:product.image),
                    content: { phase in
                        
                        if let image = phase.image {
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: 150, maxHeight: 200)
                        } else if phase.error != nil {
                            //Image("category_gallery_item_img") // Indicates an error, show default image
                        } else {
                            // Acts as a placeholder.
                            //Image("category_gallery_item_img")
                            ProgressView().progressViewStyle(.circular)
                            // Image("Mickey Mouse")
                        }
                    })
                    .overlay(alignment: .topLeading){
                        Text("-20%").padding(5).fontWeight(.bold).foregroundColor(.white).background(Color.red).cornerRadius(10.0)
                            .offset(x:10,y:10)
                    }
                    .overlay(alignment: .bottomTrailing){
                        FloatingActionButton(systemImageName: "heart")
                            .frame(alignment: .bottomLeading)
                            .offset(y:10)
                    }
                
                
            }
            VStack(alignment:.leading){
                HStack{
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Image(systemName: "star")
                    Text("(10)")
                }
                Text(product.title.components(separatedBy: " ").first ?? "").font(.caption).foregroundColor(.gray)
                Text((product.title.components(separatedBy: " ").prefix(3).joined(separator: " "))).font(.system(size: 20).bold())
                HStack{
                    //Text("15$").strikethrough().foregroundColor(.gray)
                    Text((String(format: "$%.2f", product.price))).foregroundColor(.red)
                }
            }
        }.padding()
    }
}

#Preview {
    ProductGridItem(
        product: Product(
                id: 1,
                title: "Title",
                price: 45.00,
                category: "Demo category",
                productDesc: "asda dasd asdasdasdasd asdasdasd asdasdasaaaaaaaaaaa asd  asd as d asd adasdasd asdasdasdasdasdas dasdasdasdasd asdasdasdasd asd sad as dsa daaaaad ",
                image: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
                productVariants: ["Size" : ["S","M"]]
            )
    )
}
