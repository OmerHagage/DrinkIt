//
//  test.swift
//  DrinkIt
//
//  Created by Omer Hagage on 09/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct CategoryDrinkButtonView: View{
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
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    Spacer()
                    Button(action: {
                        self.infoDrink = drink
                        UIApplication.shared.endEditing()
                        self.showSheetDrinkInfo = true
                            }, label: {
                                Image(systemName: "info.circle")
                            })
                }
                
                    
                    // Drink name
                    VStack(alignment: .leading){
                        Text(drink.id)
                            .font(.body).fontWeight(.bold)
                            .layoutPriority(1)
                           
                        Text("\(drink.volume)% Vol")
                            .font(.footnote)
                    }
                    .padding(.top, 1)
                    
                Spacer(minLength: 0)
                
                HStack{
                    Spacer()
                    // Drink image
                    DrinkImageView(imageName: self.drink.id)

                }
                    
                        
                
                   
            }.padding()
              
            
        }
        .frame(width: 150, height: 170)
        .foregroundColor(.primary)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.clear, lineWidth: 1))
//        .background(self.pressed ? Color("Rich Black") : Color("Charleston Green"))
        .background(self.pressed ? DesignStyle.drinkButtonPressed() : DesignStyle.drinkOrCocktailButton(category: ""))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black, radius: 3)
    }
}



















//
//{
//    let drink:Drink
//
//    @Binding var drinkToAdd:Set<String>
//    @State var pressed:Bool
//    @State private var showInfo = false
//
////    var image:String = "jagermeister_icon"
//
//    var body: some View {
//
//        // Drink button
//        Button(action: {
//            self.pressed.toggle()
//
//            //add to user if press
//            if (self.pressed){
//                self.drinkToAdd.insert(self.drink.id)
//            }else{
//                self.drinkToAdd.remove(self.drink.id)
//            }
//        }) {
//            VStack{
//                VStack{
//                    HStack{
//                    // Drink name
//                    Text(drink.id).fontWeight(.bold)
////                    Spacer()
//
//                        Button(action: {
//                            self.showInfo.toggle()
//                                }, label: {
//                                    Image(systemName: "info.circle")
//                                })
//                    }
//
//                    // Drink image
//                    ImageView(imageName: "jagermeister_icon")
//                        .padding(.trailing, 20)
//
//                    // Drink info button
//
//                }
//                .padding(.leading, 35.0)
//                .padding(.trailing, 15)
//
//                // show drink info if info button pressed
//                if (self.showInfo){
//                    Text(drink.summary).padding()
//                }
//            }
//        }
////        .frame( .none : 70)
//        .frame(width: 150, height: 170)
//        .foregroundColor(.white)
//        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.clear, lineWidth: 1))
////        .background(self.pressed ? Color("Rich Black") : Color("Charleston Green"))
//        .background(self.pressed ? LinearGradient(gradient: Gradient(colors: [Color("Rich Black")]), startPoint: .bottomLeading, endPoint: .topTrailing) : LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing))
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: self.pressed ? Color("Rich Black") : Color("Charleston Green"), radius: 3)
//    }
//}

//struct test_Previews: PreviewProvider {
//    static var previews: some View {
//        test()
//    }
//}
