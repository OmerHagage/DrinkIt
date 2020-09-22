//
//  ImageView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 15/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    let image:String = "jagermeister_icon"
    
    var body: some View {
        Image(image)
        .resizable()
        .scaledToFit()
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 5)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
