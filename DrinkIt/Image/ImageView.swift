//
//  ImageView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI
import FirebaseStorage
import Foundation


struct ImageView: View {
    
    // image to present
    let imageName:String
    
    
//    let r:[UIImage]
//
//    var flag:Bool
    
    
    init(imageName:String) {
//        let db = DBImages()
//        self.flag = false
//        self.r = UIimage(nme)
        self.imageName = imageName
//        if (imageName == "Dry Matrini"){
////            self.r = db.cocktailImageRequest(cocktailName: imageName)
//            db.cocktailImageRequest(cocktailName: imageName)
//            self.flag = true
//        }
//        self.r = db.cocktailImageRequest(cocktailName: imageName)
        
        
    }
    
    var body: some View {
        Image(self.imageName)
            .resizable()
            .scaledToFit()
            .colorInvert()
            .frame(width: 60, height: 60)
            .shadow(color: .white, radius: 1)
//            .clipShape(Circle())
//            .overlay(
//                Circle().stroke(Color.white.opacity(0.5), lineWidth: 2))
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView(imageName: "star")
//    }
//}
