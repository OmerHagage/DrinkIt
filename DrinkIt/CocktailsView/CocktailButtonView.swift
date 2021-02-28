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
    
    @EnvironmentObject var user:User
    @Binding var isPressed:Bool
    @Binding var infoCocktail:Cocktail
    
    @Binding var addToFavorite:Set<String>

    var body: some View {
        VStack{
            Button(action: {
                self.infoCocktail = self.cocktail
                self.isPressed = true
            })
            {
                // button detail view
                VStack{
                    // cocktail name and favorite button
                    HStack{
                        Text(cocktail.id)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        FavoriteButton(cocktailName: cocktail.id, addToFavorite: self.$addToFavorite)
                    }.padding(.top, 4)
                    Spacer()
                    // cocktail ingredients and image
                    HStack{
                        VStack(alignment: .leading){
                            ForEach(0..<self.cocktail.uncommonIngredients.count, id: \.self){ i in
                                BulletedText(text: self.cocktail.uncommonIngredients[i])
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        Spacer()
                        //todo: אולי לשנות לשם של הקוקטייל במקום סוג הכוס?
                        CocktailImageView(imageName: self.cocktail.glassKind).padding([.bottom, .trailing])
                    }
                }
            }
            .frame(height: 100)
            .foregroundColor(.primary)
            .padding()
            .overlay( RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.clear, lineWidth: 1)
            )
//            .background(Color("Charleston Green"))
            .background(DesignStyle.drinkOrCocktailButton(category: ""))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black, radius: 3)
            .padding(.all, 5.5)
        }
//        .sheet(isPresented: self.$isPressed, content: { FullCocktailView(showFullCocktailInfo: self.$isPressed, addToFavorite: self.$addToFavorite, cocktail: self.cocktail)})
    }
}


//struct CocktailButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CocktailButtonView(cocktail: Cocktail(id: "sdlfgn", recipe: "ldnkfg", ingredients: ["Df","sdf","sdf"], quantities: [1,2,3]))
//    }
//}
