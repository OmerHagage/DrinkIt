//
//  ButtonStyle.swift
//  DrinkIt
//
//  Created by Omer Hagage on 02/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct ButtonLableStyle{
    
    static func addStyle(lable:String) -> some View {
        return Text(lable)
                .foregroundColor(Color.white)
                .bold()
                .padding(.vertical , 10)
                .padding(.horizontal , 15)
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                .background(Color.black)
                .cornerRadius(20)
                .shadow(radius: 10)
    }
    
}

//struct ButtonStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonStyle()
//    }
//}
