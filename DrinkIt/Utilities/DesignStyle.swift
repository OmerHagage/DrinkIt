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
        return LinearGradient(gradient: Gradient(colors: [Color("end"), Color.black]), startPoint: .topTrailing, endPoint: .bottomLeading)
    }
    
    static func buttonStyle() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
    
    static func drinkOrCocktailButton() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("Charleston Green"),Color("Outer Space Crayola")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
    static func drinkButtonPressed() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("Rich Black")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
}

//struct DesignStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        DesignStyle()
//    }
//}
