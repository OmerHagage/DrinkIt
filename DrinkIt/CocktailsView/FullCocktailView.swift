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
    @Binding var showFullCocktail:Bool
    
    let cocktail:Cocktail
    
    var body: some View {
        ScrollView{
            VStack{
                //cocktail  name
                Text(cocktail.id)
                    .font(.title)
                    .bold()
                    .padding()
                
                //cocktail image
                ImageView(imageName: "cocktail_icon")
                    .padding()
                
                //number of pepole slide
                NumPeopleView(num: self.$peopleNum)

                //cocktail ingredients view
                IngredientsView(cocktail: self.cocktail, peopleNum: self.$peopleNum)
                
                //cocktail recipe
                VStack(alignment: .leading){
                    ForEach(cocktail.recipe, id: \.self){step in
                        BulletedText(text: step).multilineTextAlignment(.leading)
                    }
                }
                .padding()
                
                //cocktail summary
                Text(cocktail.summary)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Button("Dismiss") {
                    self.showFullCocktail = false
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
            VStack(alignment: .leading, spacing: 5.0){
                ForEach(0..<self.cocktail.alcoholQuantities.count, id: \.self){ i in
                    Text(String(self.cocktail.alcoholQuantities[i] * Double(self.peopleNum)))
                }
                ForEach(0..<self.cocktail.nonAlcoholQuantities.count, id: \.self){ i in
                    Text(String(self.cocktail.nonAlcoholQuantities[i] * Double(self.peopleNum)))
                }
            }.frame(width: 70)
            VStack(alignment: .leading, spacing: 5.0){
                ForEach(0..<self.cocktail.alcoholIngredients.count, id: \.self){ i in
                    Text(self.cocktail.alcoholIngredients[i])
                }
                ForEach(0..<self.cocktail.nonAlcoholIngredients.count, id: \.self){ i in
                    Text(self.cocktail.nonAlcoholIngredients[i])
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
            .foregroundColor(self.num == lable ? .white : Color.black)
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
