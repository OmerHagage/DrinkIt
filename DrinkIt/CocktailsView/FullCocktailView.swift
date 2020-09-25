//
//  FullCocktailView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct FullCocktailView: View {
    
    @State var peopleNum:Double = 1
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let cocktail:Cocktail
    
    var body: some View {
        ScrollView{
            VStack{
                Text(cocktail.id)
                    .font(.title)
                    .bold()
                    .padding()
                ImageView(imageName: "cocktail_icon").padding()
                   numPeopleView(num: $peopleNum)

                    VStack(alignment: .leading){
                        ForEach(0..<cocktail.alcoholIngredients.capacity){ i in
                            HStack{
                                Text(String(self.cocktail.alcoholQuantities[i] * self.peopleNum))
                                Text(self.cocktail.alcoholIngredients[i])
                            }.multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                        ForEach(0..<cocktail.nonAlcoholIngredients.capacity){ i in
                                HStack{
                                    Text(String(self.cocktail.nonAlcoholQuantities[i] * self.peopleNum))
                                    Text(self.cocktail.nonAlcoholIngredients[i])
                                }.multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            }
                    }.padding()
                
                VStack(alignment: .leading){
                    Spacer(minLength: 20)
                    Text(cocktail.recipe)
                        .padding()
                    Text(cocktail.summary)
                        .padding()
                }
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
        }
    }
}

//struct FullCocktailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCocktailView(cocktail: Cocktail(id: "fdg", recipe: "fdg", ingredients: ["fg"], quantities: [1]))
//    }
//}



struct numPeopleView: View {

    @Binding var num:Double
    
    var body: some View{
        HStack{
            Text("Number of people:")
                .font(.subheadline)
                .padding(.horizontal)
                .frame(width: 120)
            HStack{

                numButtonView(num: $num, lable: 1)
                numButtonView(num: $num, lable: 2)
                numButtonView(num: $num, lable: 3)
                numButtonView(num: $num, lable: 4)

            }
            .background(Color.black.opacity(0.3))
            .clipShape(Capsule())
            .padding()
        }
    }
}


struct numButtonView: View {
    
    @Binding var num:Double
    let lable:Double
    
    var body: some View{
        Text(String(format: "%.0f", lable))
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
