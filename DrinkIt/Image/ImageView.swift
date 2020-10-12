//
//  ImageView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI


struct ImageView: View {
    
    
    var image:String
    
    
    
    
    init(imageName:String) {
        self.image = imageName

       
    }
    
    var body: some View {
    
        Image(self.image)
            .resizable()
            .scaledToFit()
            .colorInvert()
            .frame(width: 60, height: 60)
            .shadow(color: .white, radius: 1)
//
            
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

