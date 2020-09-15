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
    
    let image:Image = Image(systemName: "arkit")
    
    
    @State var pressed = false
    
    
    

    var body: some View {
            VStack{
            Button(action: {
                self.pressed.toggle()
                    }) {
                        VStack{
                            HStack{
                                Text(cocktail.id).font(.title).fontWeight(.bold)
                                Spacer()
                                image.padding()
                            }
                            Spacer()
                            VStack{
                                ForEach(0..<cocktail.ingredients.capacity){ i in
                                    HStack{
                                        Text(String(self.cocktail.quantities[i]))
                                        Text(self.cocktail.ingredients[i])
                                    }
                                }
                            }
                        }
                        }
                        .frame(height: 100)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        
                        .shadow(radius: 2)
                        .padding(.all, 5.5)
            }
            .sheet(isPresented: self.$pressed, content: { FullCocktailView(cocktail: self.cocktail)})
            
    }
}

struct CocktailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailButtonView(cocktail: Cocktail(id: "sdlfgn", recipe: "ldnkfg", ingredients: ["Df","sdf","sdf"], quantities: [1,2,3]))
    }
}
