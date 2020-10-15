//
//  DesignStyle.swift
//  DrinkIt
//
//  Created by Omer Hagage on 12/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DesignStyle {
    @Environment(\.colorScheme) var colorScheme
    
    static func backgroundStyle() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .topTrailing, endPoint: .bottomLeading)
    }
    
    static func buttonStyle() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("1"),Color("2"),  Color("3")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
    
    static func drinkOrCocktailButton(category:String) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors:
                        [Color("\(category)1"), Color("\(category)2"), Color("\(category)3")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
    static func drinkButtonPressed() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("pressed")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
}

//struct DesignStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        DesignStyle()
//    }
//}
