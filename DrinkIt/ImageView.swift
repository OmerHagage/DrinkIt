//
//  ImageView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    let imageName:String
    
    var body: some View {
        Image(imageName)
        .resizable()
        .scaledToFit()
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white.opacity(0.5), lineWidth: 2))
        .shadow(radius: 5)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageName: "star")
    }
}
