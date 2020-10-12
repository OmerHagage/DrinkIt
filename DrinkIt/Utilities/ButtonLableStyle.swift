//
//  ButtonStyle.swift
//  DrinkIt
//
//  Created by Omer Hagage on 02/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct ButtonLableStyle{
    
    
    
//    var content: () -> Content
//
//    var body: some View{
//        self.content()
//            .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.clear, lineWidth: 1))
////                .background(Color("Charleston Green"))
//            .background(LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing))
//            .cornerRadius(20)
//            .shadow(color: Color("Charleston Green"), radius: 10)
//    }
    
    static func addStyle(lable:String) -> some View {
        return Text(lable)
                .foregroundColor(Color.white)
                .bold()
                .padding(.vertical , 10)
                .padding(.horizontal , 15)
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.clear, lineWidth: 1))
//                .background(Color("Charleston Green"))
                .background(LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(20)
                .shadow(color: Color("Charleston Green"), radius: 10)
    }
    
    static func addStyle(image:Image, lable:String) -> some View {
        return
            HStack{
                image
                    .foregroundColor(.green)
                    .imageScale(.large)
                    
                Text(lable)
                    .foregroundColor(Color.white)
                    .bold()
            }
                .padding(.vertical , 10)
                .padding(.horizontal , 15)
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.clear, lineWidth: 1))
//                .background(Color("Charleston Green"))
                .background(LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(20)
                .shadow(color: Color("Charleston Green"), radius: 10)
    }
    
}

//struct ButtonStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonStyle()
//    }
//}
