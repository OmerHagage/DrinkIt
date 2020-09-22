//
//  FullCocktailView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct FullCocktailView: View {
    
    @State var peopleNum:Float = 1
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let cocktail:Cocktail
    
    var body: some View {
        ScrollView{
            VStack{
                Text(cocktail.id)
                    .font(.title)
                    .bold()
                    .padding()
                Spacer(minLength: 20)
                   numPeopleView(num: $peopleNum)
//                HStack{
                    VStack(alignment: .leading){
                        ForEach(0..<cocktail.ingredients.capacity){ i in
                            HStack{
                                Text(String(self.cocktail.quantities[i] * self.peopleNum))
                                Text(self.cocktail.ingredients[i])
                            }
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                    }.padding()
                 
//                }
                Spacer(minLength: 20)
                Text(cocktail.recipe)
                    .padding()
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }
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



struct numPeopleView: View {

    @Binding var num:Float
    
    var body: some View{
        VStack{
            Text("Number of people:")
                .font(.subheadline)
                .padding(.horizontal)
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
    
    @Binding var num:Float
    let lable:Float
    
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
