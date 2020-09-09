//
//  DrinkList.swift
//  DrinkIt
//
//  Created by Omer Hagage on 06/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DrinkList: View {
    
    @ObservedObject private var drinksDB = DBDrinks()
    

    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack{
            
            Text("Drinks").font(.title)
            Spacer()
            
            
            ScrollView{
                ForEach(self.drinksDB.data){ data in
                    HStack {
                      DrinkButtonView(drink: data)

                    }

                }
            }
            .padding(.vertical)
//            .onAppear {UITableView.appearance().separatorStyle = .none}
 
  
          


            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("push")
                .foregroundColor(Color.white)
                .bold()
                .padding(.all , 10)
                .padding(.horizontal , 25)
                .overlay(RoundedRectangle(cornerRadius:20).stroke(Color.gray, lineWidth: 4))
                .background(Color.black)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
            
            
        }
        
        
    }
}

struct DrinkList_Previews: PreviewProvider {
    static var previews: some View {
        DrinkList()
    }
}
