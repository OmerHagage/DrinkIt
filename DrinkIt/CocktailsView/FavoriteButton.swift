//
//  FavoriteButton.swift
//  DrinkIt
//
//  Created by Omer Hagage on 08/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    let cocktailName:String
    
    @Binding var addToFavorite:Set<String>
    
    
    func checkFavorite(cocktailName:String) {
        if (self.addToFavorite.contains(cocktailName)){
            self.addToFavorite.remove(cocktailName)
        }
        else{
            self.addToFavorite.insert(cocktailName)
        }
    }
    
    var body: some View {
        Button(action: {
            checkFavorite(cocktailName: cocktailName)
        }, label: {
            if (self.addToFavorite.contains(cocktailName)){
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star")
                    .foregroundColor(.primary)
            }
        })
       
    }
}

//struct FavoriteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteButton()
//    }
//}
