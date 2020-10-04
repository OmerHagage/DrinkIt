//
//  LiquorCabinetView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 04/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

/**
 the main cabinet view, grid from user drinks
 */
struct LiquorCabinetView: View {
    // user's drinks
    let userDrinks:Set<String>
    
    // edit the drinks in the cabinet
    @Binding var edit:Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
        
            // grid of drinks
            GridView(drinks: self.userDrinks, editt: $edit)
            Spacer()
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
    }
}

//struct LiquorCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiquorCabinetView()
//    }
//}
