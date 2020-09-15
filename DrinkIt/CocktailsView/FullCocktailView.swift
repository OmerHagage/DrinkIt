//
//  FullCocktailView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct FullCocktailView: View {
    
    let cocktail:Cocktail
    
    var body: some View {
        ScrollView{
            VStack{
                Text(cocktail.id)
                    .font(.title)
                    .bold()
                    .padding()
                Spacer(minLength: 20)
                ForEach(0..<cocktail.ingredients.capacity){ i in
                    HStack{
                        Text(String(self.cocktail.quantities[i]))
                        Text(self.cocktail.ingredients[i])
                    }
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                }
                Spacer(minLength: 20)
                Text(cocktail.recipe)
                    .padding()
                Spacer()
            }
        }
    }
}

struct FullCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        FullCocktailView(cocktail: Cocktail(id: "fdg", recipe: "fdg", ingredients: ["fg"], quantities: [1]))
    }
}
