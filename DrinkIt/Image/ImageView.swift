//
//  ImageView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct DrinkImageView: View {
    
    
    var image:String
    
    func getSafeImage(named: String) -> Image {
       let uiImage =  (UIImage(named: named) ?? UIImage(named: "drink_bottle"))!
       return Image(uiImage: uiImage)
    }

    
    
    init(imageName:String) {
        self.image = imageName

       
    }
    
    var body: some View {
        self.getSafeImage(named: self.image)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .shadow(color: .white, radius: 1)
    }
}




struct CocktailImageView: View {
    
    
    var image:String
    
    func getSafeImage(named: String) -> Image {
       let uiImage =  (UIImage(named: named) ?? UIImage(named: "cocktail_icon"))!
       return Image(uiImage: uiImage)
    }

    
    
    init(imageName:String) {
        self.image = imageName

       
    }
    
    var body: some View {
//        Image(self.image)
        self.getSafeImage(named: self.image)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .shadow(color: .white, radius: 1)
    }
}
//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView(imageName: "star")
//    }
//}

