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
    let imageName:String = "cocktail_icon"
    
    @EnvironmentObject var user:User
    @State private var pressed:Bool = false
    
    @Binding var addToFavorite:Set<String>

    var body: some View {
        VStack{
            Button(action: { self.pressed = true })
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
                    }
                    Spacer()
                    // cocktail ingredients and image
                    HStack{
                        VStack(alignment: .leading){
                            ForEach(0..<self.cocktail.alcoholIngredients.count, id: \.self){ i in
                                BulletedText(text: self.cocktail.alcoholIngredients[i])
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    Spacer()
                        //todo: לשנות לשם של התמונה
                        ImageView(imageName: self.imageName).padding([.bottom, .trailing])
                    }
                }
            }
            .frame(height: 100)
            .foregroundColor(.white)
            .padding()
            .overlay( RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.clear, lineWidth: 1)
            )
//            .background(Color("Charleston Green"))
            .background(LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color("Charleston Green"), radius: 3)
            .padding(.all, 5.5)
        }
        .sheet(isPresented: self.$pressed, content: { FullCocktailView(showFullCocktail: self.$pressed, addToFavorite: self.$addToFavorite, cocktail: self.cocktail)})
    }
}


//struct CocktailButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CocktailButtonView(cocktail: Cocktail(id: "sdlfgn", recipe: "ldnkfg", ingredients: ["Df","sdf","sdf"], quantities: [1,2,3]))
//    }
//}
