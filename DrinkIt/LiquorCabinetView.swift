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
    
    private let height = UIScreen.main.bounds.height * 0.6
    private let width = UIScreen.main.bounds.width
    
    // edit the drinks in the cabinet
    @Binding var edit:Bool
    
    var body: some View {
//        ZStack{
//            VStack(spacing: (self.height - 10) / CGFloat(GridView.NUM_OF_ROWS)){
//                ForEach(1...GridView.NUM_OF_ROWS, id: \.self){ i in
//                    Rectangle()
//    //                            RoundedRectangle(cornerRadius: 20)
//                        .foregroundColor(Color("Charleston Green"))
//                        .frame(height: 5)
//                        .offset(y: 50)
//                        .shadow(color: .white, radius: 2, x: 0.0, y: -2)
//                        .padding(.horizontal)
//                }
//            }
//
            
        ScrollView(.horizontal, showsIndicators: false){
            // grid of drinks
            GridView(gridHeight: self.height, drinks: self.userDrinks, editt: $edit)
            Spacer()
        }.frame(width: self.width, height: self.height)
//        }
    }
}

//struct LiquorCabinetView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiquorCabinetView()
//    }
//}
