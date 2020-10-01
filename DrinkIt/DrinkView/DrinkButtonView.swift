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
    @State private var showInfo = false
    
    
    var bgColor:Color = Color.clear
    var selected:Bool = false
    
//    var image:String = "jagermeister_icon"
    
    
    
    
    
    var body: some View {

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
                            Text(drink.id).font(.title).fontWeight(.bold)
                            Spacer()
                            ImageView(imageName: "jagermeister_icon").padding(.trailing, 20)
                                Button(action: {
                                    self.showInfo.toggle()
                                }, label: {
                                        Image(systemName: "info.circle").frame(alignment: .topTrailing)
                                            .padding(.vertical, 10)
                                })
                        }
                        .padding(.leading, 35.0)
                        .padding(.trailing, 15)
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

