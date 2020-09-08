//
//  CocktailButtonView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 08/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct CocktailButtonView: View {
    var name:String
    var ingredients:String
    var image:Image = Image(systemName: "arkit")
    
    
    
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack{
                HStack{
                    Text(self.name).font(.title).fontWeight(.bold)
                    Spacer()
                    self.image.padding()
                }
                Spacer()
                Text(self.ingredients)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            }
//        .scaledToFit()
            .frame(height: 100)
            .foregroundColor(.black)
            .cornerRadius(20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
            
            .shadow(radius: 0.5)
            .padding(.all, 5.5)
 
            
            
            
    }
}

struct CocktailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailButtonView(name: "Negroni", ingredients: "gin,vermouth rosso,  Campari")
    }
}
