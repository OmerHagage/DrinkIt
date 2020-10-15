//
//  FullCocktailView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct FullCocktailView: View {
    
    @State private var peopleNum:Int = 1
    @Binding var showFullCocktailInfo:Bool
    @Binding var addToFavorite:Set<String>
    
    let cocktail:Cocktail
    
    var body: some View {
        VStack{
            //dismiss and favorite button
            HStack{
                Button(action: {
                    self.showFullCocktailInfo = false
                }) {
                    Image(systemName: "multiply")
                        .foregroundColor(Color("textColor"))
                }.padding()
                
                Spacer()
                
                FavoriteButton(cocktailName: cocktail.id, addToFavorite: self.$addToFavorite)
                    .padding()
            }
            
            //cocktail  name
            Text(cocktail.id)
                .font(.title)
                .bold()
                
            
            ScrollView{
                VStack{
                    VStack{
                       
                        
                        //cocktail image
                        ImageView(imageName: "cocktail_icon")
                            .padding()
                        
                        // cocktail rating
                        HStack{
                            Text("Rating: ")
                            ForEach(1...5, id: \.self){ i in
                                if (i <= self.cocktail.rating){
                                    Image(systemName: "star.fill")
                                } else {
                                    Image(systemName: "star")
                                }
                            }
                        }.padding()
                        
                        //number of pepole slide
                        NumPeopleView(num: self.$peopleNum)

                        //cocktail ingredients view
                        IngredientsView(cocktail: self.cocktail, peopleNum: self.$peopleNum)
                        
                    }
                    VStack(alignment: .leading, spacing: 2){
                        
                        // cocktail glass
                        Text("Cocktail glass:  \(self.cocktail.glassKind)").padding()
                        
                        // cocktail garnish
                        if (!self.cocktail.garnish.isEmpty){
                            HStack(spacing: 0){
                                Text("Garnish:  ")
                                Text(cocktail.garnish[0])
                                ForEach(1..<cocktail.garnish.count, id: \.self){ i in
                                    Text(", \(cocktail.garnish[i])")
                                }
                            }.padding()
                        }
              
                        //cocktail recipe
                        HStack {
                            Spacer()
                            Text("How to make it:").font(.headline).fontWeight(.heavy).underline()
                            Spacer()
                        }.padding(.top)
                        VStack(alignment: .leading, spacing: 7){
                            ForEach(cocktail.recipe, id: \.self){step in
                                BulletedText(text: step).multilineTextAlignment(.leading)
                            }
                        }
                        .padding()
                        
                        //cocktail summary
                        Text(cocktail.summary)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                }
            }
        }
    }
}


//struct FullCocktailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCocktailView(cocktail: Cocktail(id: "fdg", recipe: "fdg", ingredients: ["fg"], quantities: [1]))
//    }
//}


struct IngredientsView: View {
    let cocktail:Cocktail
    @Binding var peopleNum:Int
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 7.0){
                ForEach(0..<self.cocktail.uncommonQuantities.count, id: \.self){ i in
                    Text("\(self.cocktail.uncommonQuantities[i] * Double(self.peopleNum), specifier: "%.2f")  \(self.cocktail.uncommonQuantitiesTypes[i])")
                }
                ForEach(0..<self.cocktail.commonQuantities.count, id: \.self){ i in
                    Text("\(self.cocktail.commonQuantities[i] * Double(self.peopleNum), specifier: "%.2f")  \(self.cocktail.commonQuantitiesTypes[i])")
                }
            }
            .frame(width: 115)
            VStack(alignment: .leading, spacing: 7.0){
                ForEach(0..<self.cocktail.uncommonIngredients.count, id: \.self){ i in
                    Text(self.cocktail.uncommonIngredients[i])
                }
                ForEach(0..<self.cocktail.commonIngredients.count, id: \.self){ i in
                    Text(self.cocktail.commonIngredients[i])
                }
            }
        }
        .padding()
    }
}


struct NumPeopleView: View {
    @Binding var num:Int
    
    var body: some View{
        HStack{
            Text("Number of people:")
                .font(.subheadline)
                .padding(.horizontal)
                .frame(width: 110)
            
            // numbers Buttons
            HStack{
                ForEach(1...4, id:\.self){ i in
                    NumButtonView(num: $num, lable: i)
                }
            }
            .background(Color.black.opacity(0.3))
            .clipShape(Capsule())
            .padding()
        }
    }
}


struct NumButtonView: View {
    @Binding var num:Int
    let lable:Int
    
    var body: some View{
        Text(String(lable))
            .foregroundColor(self.num == lable ? .white : Color.white.opacity(0.3))
            .fontWeight(.bold)
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color.black.opacity(self.num == lable ? 0.5 : 0))
            .clipShape(Capsule())
            .onTapGesture {
                self.num = self.lable
        }
    }
}
