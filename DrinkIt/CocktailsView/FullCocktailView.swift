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
  
  @Binding var cocktail:Cocktail
  
  var body: some View {
    VStack{
      //dismiss and favorite button
      HStack{
        Button(action: {
          self.showFullCocktailInfo = false
        }) {
          Image(systemName: "multiply")
            .foregroundColor(.primary)
        }.padding()
        
        Spacer()
        
        FavoriteButton(cocktailName: cocktail.id, addToFavorite: self.$addToFavorite)
          .padding()
      }
      
      
      
      
      ScrollView{
        VStack{
          
          //cocktail  name
          Text(cocktail.id)
            .font(.title)
            .bold()
          
          VStack{
            // Cocktail image.
            CocktailImageView(imageName: self.cocktail.glassKind)
              .padding()
            
            // Number of people slide.
            NumPeopleView(num: self.$peopleNum)
            
            
            // Cocktail ingredients view.
            IngredientsView(cocktail: self.$cocktail, peopleNum: self.$peopleNum)
            
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


struct IngredientsView: View {
  @Binding var cocktail:Cocktail
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
        .frame(width: 110, height: 45)
      
      // numbers Buttons
      Picker(selection: self.$num, label: Text("Picker"), content: /*@START_MENU_TOKEN@*/{
        ForEach(1...4, id:\.self){ i in
          Text(String(i)).tag(i)
        }
      }/*@END_MENU_TOKEN@*/).pickerStyle(SegmentedPickerStyle())
        .padding(.trailing)
    }
  }
}
