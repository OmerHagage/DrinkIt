//
//  DrinkList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DrinkList: View {
//    @ObservedObject private var drinksDB = DBDrinks()
    @EnvironmentObject var dbDrinks:DBDrinks
    
    @State var drinkToAdd = Set<String>()
    @State var searchText:String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    @State var categoriesOrList:String
//    @State var categoriesOrList = "list"
    
    
    @State var showDrinkInfo:Bool = false
    @State var infoDrink = Drink(id: "", summary: "", category: "")
    
    @State var emptyAdd:Bool = false
    @State var showEditCategoriesOrListSheet:Bool = false

    
//    init() {
//        self.categoriesOrList = "categories"
////            user.drinksViewPriority
//    }
    
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
        ZStack{
        
        
        VStack{
            
            HStack{
                Button(action: {
                    // add chosen drinks to the user
                    if (self.drinkToAdd.isEmpty){
                        self.emptyAdd = true
                    }
                    else{
                        self.user.userDrinks.formUnion(self.drinkToAdd)
                        AppDelegate.staticSaveContext(context: self.managedObjectContext)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    //todo: לבדוק אם אפשר לשנות את העיצוב לכל הhstack
//                    HStack{
//                        Image(systemName: "plus").foregroundColor(.green)
//                        Text("Add to your liquor cabinet")
                        ButtonLableStyle.addStyle(lable: "+ Add to your liquor cabinet")
//                    }
                    
                }
                .alert(isPresented: self.$emptyAdd, content: {
                    Alert(title: Text("Add drinks"), message: Text("Please select drinks in order to add to your liquor cabinet"), dismissButton: .default(Text("OK")))
                })
                
                Spacer()
                
                Button(action: {self.showEditCategoriesOrListSheet = true}, label: {
                    Image(systemName: "slider.horizontal.3").foregroundColor(.white)
                })
                
                //todo: למחוק
//                EditCategoriesOrListButton(categoriesOrList: self.$categoriesOrList)
                
            }.padding(.horizontal)
            
            
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            
            // Drinks list - show only drinks that the user don't have
            if (self.categoriesOrList == "categories"){
                List{
                    ForEach(self.dbDrinks.data.keys.sorted(), id: \.self){ category in
                        VStack(alignment: .leading){
                            Text(category).font(.headline).fontWeight(.bold)
                                .padding(.leading)
                                .padding(.top, 3)
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 5){
                                    ForEach(self.dbDrinks.data[category]!.filter(filterSearch(drink:))){
                                        drink in
                                        CategoryDrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd, pressed: self.drinkToAdd.contains(drink.id) || self.user.userDrinks.contains(drink.id), showSheetDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink)
                                            
                                    
                                            
                                    }
                                }.padding(.leading)
                            }.padding(.bottom, 3)
                        }
                    
                    }
                    .listRowInsets(EdgeInsets())
                }.padding(.top, 1)
                .onAppear(){
                    UITableView.appearance().showsVerticalScrollIndicator = false
                }
            }
            else{
                ScrollView(.vertical, showsIndicators: true){
                    VStack(spacing: 7){
                        ForEach(self.dbDrinks.data.keys.sorted(), id: \.self){ category in
                            ForEach(self.dbDrinks.data[category]!.filter(filterSearch(drink:))){
                                drink in
                                ListDrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd, pressed: self.drinkToAdd.contains(drink.id) || self.user.userDrinks.contains(drink.id), showSheetDrinkInfo: self.$showDrinkInfo, infoDrink: self.$infoDrink)
                                        .padding(.horizontal)

                            }
                        }
                    }
                }
                .padding(.top, 1)
            }
            

            
            // add drinks to the user and dismiss the view
//            Button(action: {
//                // add chosen drinks to the user
//                self.user.userDrinks.formUnion(self.drinkToAdd)
//                AppDelegate.staticSaveContext(context: self.managedObjectContext)
//                self.presentationMode.wrappedValue.dismiss()
//
//            }) {
//                ButtonLableStyle.addStyle(lable: "Add")
//            }.padding(2.0)
            
        }
        .navigationBarTitle("Drinks")
//        .navigationBarItems(trailing: EditCategoriesOrListButton(categoriesOrList: self.$categoriesOrList))


            
            
            HalfModalView(isShown: self.$showDrinkInfo){
                VStack(alignment: .leading){
                    HStack{
                        Button(action: {
                            self.showDrinkInfo = false
                        }, label: {
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text(self.infoDrink.id).font(.title).fontWeight(.bold)
                            Text("\(self.infoDrink.volume)% Vol").font(.body)
                        }
                        
                        
                        Spacer()
                        
                        //todo: set image drink
                        ImageView(imageName: "jagermeister_icon")
                    }.padding(.top)
                   
                    Text(self.infoDrink.summary)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                   
                    Spacer()
                    
                }
            }
            
            HalfModalView(isShown: self.$showEditCategoriesOrListSheet, modalHeight: 200){
                EditCategoriesOrListButton(isShown: self.$showEditCategoriesOrListSheet, categoriesOrList: self.$categoriesOrList)
            }
            
        
        }
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList(categoriesOrList: "category")
    }
}


struct EditCategoriesOrListButton: View {
    @Binding var isShown:Bool
    @Binding var categoriesOrList:String
    
    @EnvironmentObject var user:User
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.isShown = false
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.white)
                })
                
                Spacer()
            }.padding(.bottom)
            Divider()
            Button(action: {
                self.categoriesOrList = "categories"
                self.user.drinksViewPriority  = "categories"
                AppDelegate.staticSaveContext(context: managedObjectContext)
            }, label: {
                HStack{
                    Text("Categories view").foregroundColor(.white)
                    Spacer()
                    if (self.categoriesOrList == "categories"){
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.red)
                    }
                }
            })
            Divider()
            Button(action: {
                self.categoriesOrList = "list"
                self.user.drinksViewPriority  = "list"
                AppDelegate.staticSaveContext(context: managedObjectContext)
            }, label: {
                HStack{
                    Text("List view").foregroundColor(.white)
                    Spacer()
                    if (self.categoriesOrList == "list"){
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.red)
                    }
                }
            })
        Spacer()
        
        }.padding(.top)
    }
}
