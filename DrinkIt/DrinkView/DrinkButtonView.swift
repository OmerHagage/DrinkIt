//
//  DrinkView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct DrinkButtonView: View{

    
    @EnvironmentObject var user:User
    @Binding var drinkToAdd:Set<String>
           
    
    let drink:Drink
    
    @State private var pressed = false
    
    
    var bgColor:Color = Color.clear
    var selected:Bool = false
    var image:Image = Image(systemName: "circle")
    
    
    
    
    
    var body: some View {
        Button(action: {
            
            self.pressed.toggle()
            
            //add to user if press
            if (self.pressed){
                self.drinkToAdd.insert(self.drink.name)
            }else{
                self.drinkToAdd.remove(self.drink.name)
            }
            
            
                }) {
                    VStack{
                        HStack{
                            Text(drink.name).font(.title).fontWeight(.bold)
                            Spacer()
                            self.image.padding()
                        }
                        .padding(.horizontal, 35.0)
                    }
                    }
        .frame(height: 50)
        .foregroundColor(Color.black)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3))
        .background(self.pressed ? Color.black.opacity(0.2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
        
        
        
            
//
//
//    .border(RoundedRectangle(cornerRadius: 20))
//            .stroke(Color.black, lineWidth: 3)
//                    .foregroundColor(.black)
//                    .cornerRadius(20)
//
//                    .padding()
//
////
//
//                    .shadow(radius: 0.5)
//            .padding(.all, 5.5)
          
          
    }
}

//struct DrinkButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinkButtonView(drinkToAdd: Binding<Set<String>>, drink: Drink(id: "dsfdsf", name: "fdgdfdf") )
//    }
//}

