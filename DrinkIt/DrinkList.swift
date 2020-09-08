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
    
    @State private var drinksToAdd = Set<DrinkView>()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        VStack{
              List {
                
                
                ForEach(0..<drinksDB.data.count){ i in HStack {
                    Button(action: {
                        if (!self.drinksDB.data[i].selected) {
                            self.drinksToAdd.insert(self.drinksDB.data[i])
                            self.drinksDB.data[i].bgColor = Color.gray
                            self.drinksDB.data[i].selected = true
                        }
                        else {
                            self.drinksDB.data[i].bgColor = Color.clear
                            self.drinksDB.data[i].selected = false
                            self.drinksToAdd.remove(self.drinksDB.data[i])
                        }

                    }) {
                        self.drinksDB.data[i]
                    } .background(self.drinksDB.data[i].bgColor)
                    
                }
                .padding()
               
                }
                }
                .padding()
                .background(/*@START_MENU_TOKEN@*/Color.orange/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .padding()
            
            
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
