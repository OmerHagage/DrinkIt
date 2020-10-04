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
    @State private var pressed = false

    var body: some View {
        VStack{
            Button(action: { self.pressed.toggle() }) {
                CocktailButtonDetails(cocktail: self.cocktail)
            }
            .frame(height: 100)
            .foregroundColor(.black)
            .padding()
            .overlay( RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 3)
            )
            .shadow(radius: 2)
            .padding(.all, 5.5)
        }
        .sheet(isPresented: self.$pressed, content: { FullCocktailView(showFullCocktail: self.$pressed, cocktail: self.cocktail)})
    }
}


//struct CocktailButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CocktailButtonView(cocktail: Cocktail(id: "sdlfgn", recipe: "ldnkfg", ingredients: ["Df","sdf","sdf"], quantities: [1,2,3]))
//    }
//}


struct CocktailButtonDetails: View {
    let cocktail: Cocktail
    let imageName:String = "cocktail_icon"
    
    @EnvironmentObject var user:User
    
    var body: some View {
        VStack{
            // cocktail name and favorite button
            HStack{
                Text(cocktail.id)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                FavoriteButton(favorite: self.user.userFavoriteCocktails.contains(cocktail.id), cocktailName: cocktail.id)
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
            ImageView(imageName: self.imageName).padding([.bottom, .trailing])
            }
        }
    }
}


//todo: fix the favorite button
struct FavoriteButton: View {
    @State var favorite:Bool
    let cocktailName:String
    
    
    @EnvironmentObject var user:User
    @Environment(\.managedObjectContext) var managedObjectContext
    
    func saveUser(){
        do{
            try self.managedObjectContext.save()
        }
        catch{
            print(error)
            exit(EXIT_FAILURE)
        }
    }
    
    func checkFavorite(cocktailName:String) {
        if (favorite){
            self.user.userFavoriteCocktails.remove(cocktailName)
        }
        else{
            self.user.userFavoriteCocktails.insert(cocktailName)
        }
        saveUser()
    }
    
    var body: some View {
        Button(action: {
            checkFavorite(cocktailName: cocktailName)
            favorite.toggle()
        }, label: {
            //                                    if (self.user.userFavoriteCocktails.contains(cocktail.id)){
            if (favorite){
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star")
            }
        })
       
    }
}

