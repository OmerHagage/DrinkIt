//
//  ButtonStyle.swift
//  DrinkIt
//
//  Created by Omer Hagage on 02/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct ButtonLableStyle {

  static func addStyle(lable:String) -> some View {
    return Text(lable)
      .foregroundColor(.primary)
      .bold()
      .padding(.vertical , 10)
      .padding(.horizontal , 15)
      .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.clear, lineWidth: 1))
      .background(DesignStyle.buttonStyle())
      .cornerRadius(20)
      .shadow(color: .black, radius: 4)
  }

  static func addStyle(image:Image, lable:String) -> some View {
    return
    HStack{
      image
        .foregroundColor(.green)
        .imageScale(.large)
        .font(Font.callout.weight(.semibold))

      Text(lable)
        .foregroundColor(.primary)
        .bold()
    }
    .padding(.vertical , 10)
    .padding(.horizontal , 15)
    .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.clear, lineWidth: 1))
    .background(DesignStyle.buttonStyle())
    .cornerRadius(20)
    .shadow(color: .black, radius: 4)
  }

}
