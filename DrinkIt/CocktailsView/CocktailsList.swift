//
//  CocktailsList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct CocktailsList: View {
//    @ObservedObject private var datas = DBCocktails()
    @EnvironmentObject var dbCocktails:DBCocktails
    @State private var searchText:String = ""
    @State var filterAcordingToUserDrinks:Bool = false
    
    @EnvironmentObject var user:User
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var addToFavorite:Set<String>
    @State private var ShowScroll = "All Cocktails"
  
    
    /**
     searchBar filter function
     */
    private func filterSearch(cocktailName: String) -> Bool {
        if self.searchText.isEmpty{
            return true
        }
        for word in cocktailName.split(separator: " "){
            if word.lowercased().starts(with: self.searchText.lowercased()){
                return true
            }
        }
        return false
    }
    
    /**
     filter by user drinks
     */
    private func filterByUserDrinks(cocktail: Cocktail) -> Bool {
        if filterAcordingToUserDrinks{
            return user.userDrinks.isSuperset(of: cocktail.alcoholIngredients)
        }
        return true
    }
    
    /**
     filter by showing scroll
     */
    private func filterByShowingScroll(cocktail: Cocktail) -> Bool {
        if (self.ShowScroll == "Favorite Cocktails"){
            return self.addToFavorite.contains(cocktail.id)
        }
        return true
    }
    
    /**
     filter function:
        filter the cocktail db acording to the searchBar
        if @filteSearch == true, filter the cocktail db acording to the user drinks
     */
    private func filterData(cocktail:Cocktail) -> Bool {
        return filterSearch(cocktailName: cocktail.id) && filterByUserDrinks(cocktail: cocktail) && filterByShowingScroll(cocktail: cocktail)
    }
    
    private func updateFavorite(){
        self.user.userFavoriteCocktails = self.addToFavorite
        AppDelegate.staticSaveContext(context: self.managedObjectContext)
    }

    var body: some View {
        VStack{
            
            HStack{
                BarButtonView(num: self.$ShowScroll, lable: "All Cocktails")
                BarButtonView(num: self.$ShowScroll, lable: "Favorite Cocktails")
            }
            .background(Color.white.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding([.top, .leading, .trailing])
            
            
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            // cocktails list
            ScrollView(.vertical, showsIndicators: true){
                VStack(spacing: 0 ){
                    ForEach(self.dbCocktails.data.filter(filterData(cocktail:))){ cocktail in
                        CocktailButtonView(cocktail: cocktail, addToFavorite: self.$addToFavorite)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 1)
            .onDisappear(perform: updateFavorite)
        }.navigationBarTitle("Cocktails List")
    }
}

//struct CocktailsList_Previews: PreviewProvider {
//    static var previews: some View {
//        CocktailsList()
//
//}
//}


struct BarButtonView: View {
    @Binding var num:String
    let lable:String
    
    var body: some View{
        Text(String(lable))
            .foregroundColor(self.num == lable ? .white : Color.white.opacity(0.4))
            .fontWeight(.bold)
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color.white.opacity(self.num == lable ? 0.6 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                self.num = self.lable
        }
    }
}
