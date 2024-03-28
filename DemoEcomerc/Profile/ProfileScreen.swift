//
//  ProfileScreen.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import SwiftUI
import SwiftData

struct ProfileScreen: View {
    
    @Environment(\.modelContext) var context
    
    @Query var token:[AuthToken]
    
    @State var viewModel = ProfileViewModel()
    
    @EnvironmentObject var navCoordinator : NavCoordinator
    
    var body: some View {
        if viewModel.user != nil{
            VStack(alignment: .leading){
                Text("My Profile").font(.system(size: 35)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack{
                    Image(systemName: "person.crop.circle").resizable().frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text("\(viewModel.user!.name.firstname) \(viewModel.user!.name.lastname)").fontWeight(.bold)
                        Text(viewModel.user!.email).font(.system(size: 15)).foregroundColor(.gray)
                    }
                }
                ProfileItem(title: "Orders", subtitle: "View all orders"){
                    navCoordinator.navigateTo(route: Route.PreviousOrders(1))
                }
                ProfileItem(title: "Address", subtitle: "\(viewModel.user!.address.city), \(viewModel.user!.address.street) - \(viewModel.user!.address.number)")
                ProfileItem(title: "Phone number", subtitle: viewModel.user!.phone)
                
                Spacer().frame(height: 50)
                
                AccentButton(text: "Logout") {
                    print(token)
                    context.delete(token[0])
                    navCoordinator.popToRoot()
                }
                AccentButton(text: "Delete account") {
                    viewModel.deleteUser()
                    navCoordinator.popToRoot()
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
            
        }else{
            ProgressView().progressViewStyle(.circular)
        }
    }
}

struct ProfileItem:View {
    
    var title:String
    var subtitle:String
    var onItemClick: ()->Void = {}
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title).fontWeight(.semibold)
            Text(subtitle).font(.system(size: 12)).foregroundColor(.gray)
        }.padding().onTapGesture {
            onItemClick()
        }
    }
}

#Preview {
    ProfileScreen(
        //        user: User(id: "1", email: "email@email.com", username: "Username", password: "sdasd", name: Name(firstname: "aca", lastname: "Mit"), address: Address(city: "Nis", street: "Asdf", number: 44), phone: "32040312321")
    )
}
