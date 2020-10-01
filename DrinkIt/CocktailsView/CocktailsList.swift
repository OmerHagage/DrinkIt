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
    @State var searchText:String = ""
    @State var filterSearch:Bool = false
    
    @EnvironmentObject var user:User
    
    func filterData(cocktail:Cocktail) -> Bool {
        let searchBarUse = self.searchText.isEmpty ? true : cocktail.id.lowercased().starts(with: self.searchText.lowercased())
        if filterSearch{
            return searchBarUse && user.userDrinks.isSuperset(of: cocktail.alcoholIngredients)
        }
        return searchBarUse
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            SearchBar(text: $searchText).padding(.top)
            
            ScrollView{
            
                
                ForEach(self.datas.data.filter(filterData(cocktail:))){ cocktail in
                    HStack {
                        CocktailButtonView(cocktail: cocktail)

                    }

                }
            }
            .padding()
//            .onAppear {UITableView.appearance().separatorStyle = .none}
            
          
            
        }.navigationBarTitle("Cocktails List")
        
    }
    
}

struct CocktailsList_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsList()
    }
}
