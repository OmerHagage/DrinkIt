//
//  DrinkView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ListDrinkButtonView: View{
    let drink:Drink
  
    @Binding var drinkToAdd:Set<String>
    @State var pressed:Bool
    
    @Binding var showSheetDrinkInfo:Bool
    @Binding var infoDrink:Drink

    @EnvironmentObject var user:User
//    var image:String = "jagermeister_icon"
    
    var body: some View {
        
        // Drink button
        Button(action: {
            if (!self.user.userDrinks.contains(drink.id)){
                self.pressed.toggle()
            }
            
            
            //add to user if press
            if (self.pressed && !self.user.userDrinks.contains(drink.id)){
                self.drinkToAdd.insert(self.drink.id)
            }else{
                self.drinkToAdd.remove(self.drink.id)
            }
        }) {
                HStack{
                    
                    // Drink name
                    VStack(alignment: .leading){
                        Text(drink.id).font(.headline).fontWeight(.bold)
                        Text("\(drink.volume)% Vol").font(.subheadline)
                    }
                    
                    Spacer()
                    
                    // Drink image
                    ImageView(imageName: "drink_bottle")
                        .padding(.trailing, 20)
                    
                    HStack(alignment: .top){
                        // Drink info button
                        Button(action: {
                            self.infoDrink = drink
                            UIApplication.shared.endEditing()
                            self.showSheetDrinkInfo = true
                                }, label: {
                                    Image(systemName: "info.circle")
                                })
                    }
                   
                }
                .padding(.leading, 35.0)
                .padding(.trailing, 15)
        }
        .frame(height: 70)
        .foregroundColor(Color("textColor"))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.clear, lineWidth: 1))
//        .background(self.pressed ? Color("Rich Black") : Color("Charleston Green"))
        .background(self.pressed ? DesignStyle.drinkButtonPressed() : DesignStyle.drinkOrCocktailButton(category: ""))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black, radius: 3)
    }
}

//struct DrinkButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinkButtonView(drinkToAdd: Binding<Set<String>>, drink: Drink(id: "dsfdsf", name: "fdgdfdf") )
//    }
//}

