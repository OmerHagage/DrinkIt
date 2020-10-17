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
    @Environment(\.colorScheme) var colorScheme
    
    @State var addToFavorite:Set<String>
    @State private var ShowOnlyFavorite:Bool = false
    
    @State var showCocktailInfo:Bool = false
    @State var infoCocktail = Cocktail()
    
    
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
            return user.userDrinks.isSuperset(of: cocktail.uncommonIngredients)
        }
        return true
    }
    
    /**
     filter by showing scroll
     */
    private func filterByShowingScroll(cocktail: Cocktail) -> Bool {
        if (self.ShowOnlyFavorite){
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
            
            // show only favorite
            Picker("mode", selection: self.$ShowOnlyFavorite, content: /*@START_MENU_TOKEN@*/{
                Text("All Cocktails").tag(false)
                Text("Favorite Cocktails").tag(true)
            }/*@END_MENU_TOKEN@*/).pickerStyle(SegmentedPickerStyle())
            .padding([.top, .leading, .trailing])
            
            
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            // cocktails list
            ScrollView(.vertical, showsIndicators: true){
                ForEach(self.dbCocktails.data.filter(filterData(cocktail:))){ cocktail in
                    VStack(spacing: 0){
                        CocktailButtonView(cocktail: cocktail, isPressed: self.$showCocktailInfo, infoCocktail: self.$infoCocktail, addToFavorite: self.$addToFavorite)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 1)
            .onDisappear(perform: updateFavorite)
        }.navigationBarTitle("Cocktails List")
        .sheet(isPresented: self.$showCocktailInfo){
            FullCocktailView(showFullCocktailInfo: self.$showCocktailInfo, addToFavorite: self.$addToFavorite, cocktail: self.$infoCocktail)
                .preferredColorScheme(self.colorScheme)
        }
    }
}

//struct CocktailsList_Previews: PreviewProvider {
//    static var previews: some View {
//        CocktailsList()
//
//}
//}


