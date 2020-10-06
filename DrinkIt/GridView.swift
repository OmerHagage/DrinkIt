//
//  GridView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct GridView: View {
    // grid height
    let height:CGFloat
    
    // array divided to chunks (number of drinks in each column)
    private var userDrinks:[[String]]
   
    // edit the drinks in the cabinet
    @Binding var edit:Bool
    
    //todo: check the real button size
    static let NUM_OF_ROWS = Int((UIScreen.main.bounds.height * 0.6)/130)
    //todo: check the real button size
    static let NUM_OF_COLS = CGFloat(ceil(UIScreen.main.bounds.width / ((UIScreen.main.bounds.height * 0.65) / CGFloat(GridView.NUM_OF_ROWS))))
    
    /**
     initialize the  grid view and builds chunks of the array
     */
    init(gridHeight:CGFloat, drinks:Set<String>, editt:Binding<Bool>) {
        self.userDrinks = GridView.toArray(drinks: drinks)
        //todo: check what is _edit
        self._edit = editt
        self.height = gridHeight
    }
    
    /**
     build by alphabetical order the chunks of the array
     */
    static func toArray(drinks:Set<String>) -> [[String]] {
        
        var count = 0
        var arr = [[String]]()
        var innerArr = [String]()
        for item in drinks.sorted() {
            if (count < GridView.NUM_OF_ROWS){
                innerArr.append(item)
                count += 1
            }
            if (count == GridView.NUM_OF_ROWS) {
                arr.append(innerArr)
                innerArr = [String]()
                count = 0
            }
        }
        arr.append(innerArr)
        return arr
    }
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(self.userDrinks, id: \.self){ chunk in
                VStack(spacing: 0){
                    
                    ForEach(chunk, id: \.self){ drink in
                        CabinetDrinkView(drinkName: drink, edit: self.$edit)
                            .frame(width: UIScreen.main.bounds.width / GridView.NUM_OF_COLS, height: self.height / CGFloat(GridView.NUM_OF_ROWS))
                    }
                    Spacer(minLength: 0)
                }
            }
        }
    }
}



/**
 the view of each drink in the cabinet
 */
struct CabinetDrinkView: View {
    
    // drink name
    let drinkName:String
    
    // make space to see the full drink name
    @State var fullText = false
    
    // edit the drinks in the cabinet - add (-) button to the  drink view
    @Binding var edit:Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var user:User
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                ImageView(imageName: "jagermeister_icon")
                    .opacity(self.edit == false ? 1: 0.3)
                if (self.edit){
                    Image(systemName: "minus.circle.fill").foregroundColor(.red).imageScale(.large)
                        .offset(x: -30, y: -30)
//                        .frame(alignment: .topLeading)
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        self.user.userDrinks.remove(drinkName)
                        AppDelegate.staticSaveContext(context: self.managedObjectContext)
                    })
                }
            }
//            .padding(.horizontal)
            Text(drinkName)
                .layoutPriority(1)
                .frame(width: self.fullText == false ? (UIScreen.main.bounds.width / GridView.NUM_OF_COLS) - 20 : .none ,height: 30)
                .multilineTextAlignment(.center)
                .opacity(self.edit == false ? 1: 0.3)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.fullText.toggle()
                })
        }
//        .padding(.top, 10.0)
//        .padding(.leading, 22)
    }
}
