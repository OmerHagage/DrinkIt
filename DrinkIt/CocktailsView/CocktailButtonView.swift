//
//  CocktailButtonView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 08/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct CocktailButtonView: View {
    
    let cocktail: Cocktail
    var image:Image = Image(systemName: "arkit")
    
    
    

    var body: some View {
        Button(action: {
            
        }) {
            VStack{
                HStack{
                    Text(cocktail.name).font(.title).fontWeight(.bold)
                    Spacer()
                    self.image.padding()
                }
                Spacer()
                Text(cocktail.ingredients)
                    .multilineTextAlignment(.leading)
                Text(cocktail.recipe)
                .multilineTextAlignment(.leading)
                Spacer()
            }
            }
//        .scaledToFit()
            .frame(height: 100)
            .foregroundColor(.black)
            .cornerRadius(20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
            
            .shadow(radius: 2)
            .padding(.all, 5.5)
 
            
            
            
    }
}

struct CocktailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailButtonView(cocktail: Cocktail(id: "sdlfgn", name: "lgdfn", ingredients: "kdjnfg", recipe: "ldnkfg"))
    }
}

