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

    
    
    //todo: check if we can use the function from contentView
    func saveUser(){
          do{
              try self.managedObjectContext.save()
          }
          catch{
              print(error)
              exit(EXIT_FAILURE)
          }
    }
    
    
    var body: some View {
        VStack{
            
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            // Drinks list - show only drinks that the user don't have
            ScrollView(.vertical, showsIndicators: true){
                ForEach(self.drinksDB.data.filter({self.searchText.isEmpty ? true : $0.id.lowercased().starts(with: self.searchText.lowercased())}))
                    { drink in
                    if(!self.user.userDrinks.contains(drink.id)){
                        
                        //Drink button
                        DrinkButtonView(drink: drink, drinkToAdd: self.$drinkToAdd)
                                .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 1)
            
        
 
  
          


//            Spacer()
            
            Button(action: {
                // add chosen drinks to the user
                self.user.userDrinks.formUnion(self.drinkToAdd)
                self.saveUser()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                ButtonLableStyle.addStyle(lable: "Add")
            }
        }.navigationBarTitle("Drinks")
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList()
    }
}


