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
     filter function:
        filter the cocktail db acording to the searchBar
        if @filteSearch == true, filter the cocktail db acording to the user drinks
     */
    func filterData(cocktail:Cocktail) -> Bool {
        let searchBarUse = self.searchText.isEmpty ? true : cocktail.id.lowercased().starts(with: self.searchText.lowercased())
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
                ForEach(self.datas.data.filter(filterData(cocktail:))){ cocktail in
                    CocktailButtonView(cocktail: cocktail)
                        .padding(.horizontal)
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
