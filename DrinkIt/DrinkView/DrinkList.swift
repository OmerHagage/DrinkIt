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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    
    @State var drinkToAdd = Set<String>()
    @State var searchText:String = ""

    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
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
            
            
          

            
            
            
            Spacer()
            
//            UISearchBar
            SearchBar(text: $searchText).padding(.top)
            
            ScrollView{
                ForEach(self.drinksDB.data.filter({self.searchText.isEmpty ? true : $0.id.lowercased().starts(with: self.searchText.lowercased())
                    })){ drink in
                    if(!self.user.userDrinks.contains(drink.id)){
                        HStack {
                            DrinkButtonView(drinkToAdd: self.$drinkToAdd, drink: drink)
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(.horizontal)
                                
                        }
                    }
                }
            }
            .padding(.vertical)
            
        
 
  
          


            Spacer()
            
            Button(action: {
                self.user.userDrinks.formUnion(self.drinkToAdd)
                self.saveUser()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add")
                .foregroundColor(Color.white)
                .bold()
                .padding(.all , 10)
                .padding(.horizontal , 25)
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                .background(Color.black)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        
        }.navigationBarTitle("Drinks")
//        .frame(height: UIScreen.main.bounds.height)
        
        
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList()
    }
}


