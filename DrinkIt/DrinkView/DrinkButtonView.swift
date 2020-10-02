//
//  DrinkView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct DrinkButtonView: View{
    let drink:Drink
  
    @Binding var drinkToAdd:Set<String>
    @State private var pressed = false
    @State private var showInfo = false

//    var image:String = "jagermeister_icon"
    
    var body: some View {
        
        // Drink button
        Button(action: {
            self.pressed.toggle()

            //add to user if press
            if (self.pressed){
                self.drinkToAdd.insert(self.drink.id)
            }else{
                self.drinkToAdd.remove(self.drink.id)
            }
        }) {
            VStack{
                HStack{
                    
                    // Drink name
                    Text(drink.id).font(.title).fontWeight(.bold)
                    Spacer()
                    
                    // Drink image
                    ImageView(imageName: "jagermeister_icon")
                        .padding(.trailing, 20)
                    
                    // Drink info button
                    Button(action: {
                        self.showInfo.toggle()
                            }, label: {
                                Image(systemName: "info.circle")
                                })
                }
                .padding(.leading, 35.0)
                .padding(.trailing, 15)
                
                // show drink info if info button pressed
                if (self.showInfo){
                    Text(drink.summary).padding()
                }
            }
        }
        .frame(height: self.showInfo ? .none : 70)
        .foregroundColor(Color.black)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3))
        .background(self.pressed ? Color.black.opacity(0.2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
    }
}

//struct DrinkButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinkButtonView(drinkToAdd: Binding<Set<String>>, drink: Drink(id: "dsfdsf", name: "fdgdfdf") )
//    }
//}

