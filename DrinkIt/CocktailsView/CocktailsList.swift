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
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("Cocktails List")
            Spacer()
            List{
            
                
                ForEach(self.datas.data){ data in
                    HStack {
                        CocktailButtonView(name: data.name, ingredients: data.ingredients)

                    }

                }
            }
            .onAppear {UITableView.appearance().separatorStyle = .none}
            
          
            
        }
        
    }
    
}

struct CocktailsList_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsList()
    }
}
