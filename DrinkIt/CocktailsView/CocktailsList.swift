//
//  CocktailsList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct CocktailsList: View {
    @ObservedObject private var datas = DBCocktails()
    @State private var searchText:String = ""
    @State var filterSearch:Bool = false
    
    @EnvironmentObject var user:User
    
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
     filter function:
        filter the cocktail db acording to the searchBar
        if @filteSearch == true, filter the cocktail db acording to the user drinks
     */
    private func filterData(cocktail:Cocktail) -> Bool {
        let searchBarUse = filterSearch(cocktailName: cocktail.id)
        if filterSearch{
            return searchBarUse && user.userDrinks.isSuperset(of: cocktail.alcoholIngredients)
        }
        return searchBarUse
    }
    

    var body: some View {
        VStack{
            // search bar
            SearchBar(text: $searchText).padding(.top)
            
            // cocktails list
            ScrollView(.vertical, showsIndicators: true){
                VStack(spacing: 0 ){
                    ForEach(self.datas.data.filter(filterData(cocktail:))){ cocktail in
                        CocktailButtonView(cocktail: cocktail)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 1)
        }.navigationBarTitle("Cocktails List")
    }
}

struct CocktailsList_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsList()
    }
}
