//
//  DrinkList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DrinkList: View {
    @ObservedObject private var drinksDB = DBDrinks()
    
    @State var drinkToAdd = Set<String>()
    @State var searchText:String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User

    /**
     searchBar filter function
     */
    private func filterSearch(drink: Drink) -> Bool {
        if self.searchText.isEmpty{
            return true
        }
        for word in drink.id.split(separator: " "){
            if word.lowercased().starts(with: self.searchText.lowercased()){
                return true
            }
        }
        return false
    }
    
    
    var body: some View {
        VStack{
            
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            
            // Drinks list - show only drinks that the user don't have
            ScrollView(.vertical, showsIndicators: true){
                VStack(spacing: 7){
                    ForEach(self.drinksDB.data.filter(filterSearch(drink:))) { drink in
                        if(!self.user.userDrinks.contains(drink.id)){
                            
                            //Drink button
                            DrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd)
                                    .padding(.horizontal)
                            }
                        }
                }
            }
            .padding(.top, 1)
            
            // add drinks to the user and dismiss the view
            Button(action: {
                // add chosen drinks to the user
                self.user.userDrinks.formUnion(self.drinkToAdd)
                AppDelegate.staticSaveContext(context: self.managedObjectContext)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                ButtonLableStyle.addStyle(lable: "Add")
            }.padding([.top, .leading, .trailing], 2.0)
            
        }.navigationBarTitle("Drinks")
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList()
    }
}


//todo: add button on the bottom of the scrollView
//var body: some View {
//    VStack{
//
//        // search bar
//        SearchBar(text: $searchText).padding(.top)
//
//        ZStack{
//
//        // Drinks list - show only drinks that the user don't have
//        ScrollView(.vertical, showsIndicators: true){
//            VStack(spacing: 7){
//                ForEach(self.drinksDB.data.filter(filterSearch(drink:))) { drink in
//                    if(!self.user.userDrinks.contains(drink.id)){
//
//                        //Drink button
//                        DrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd)
//                                .padding(.horizontal)
//                        }
//                    }
//            }
//        }
//        .padding(.top, 1)
//
//            VStack{
//                Spacer()
//                ZStack{
//                    RoundedRectangle(cornerRadius: 30).edgesIgnoringSafeArea(.bottom)
//                        .frame(width: UIScreen.main.bounds.width, height: 50).foregroundColor(.black).opacity(0.8)
//        // add drinks to the user and dismiss the view
//        Button(action: {
//            // add chosen drinks to the user
//            self.user.userDrinks.formUnion(self.drinkToAdd)
//            AppDelegate.staticSaveContext(context: self.managedObjectContext)
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            ButtonLableStyle.addStyle(lable: "Add")
//        }.padding([.top, .leading, .trailing], 2.0)
//                }
//            }
//        }
//    }.navigationBarTitle("Drinks")
//}
