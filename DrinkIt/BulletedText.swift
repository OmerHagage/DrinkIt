//
//  BulletedText.swift
//  DrinkIt
//
//  Created by Omer Hagage on 25/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct BulletedText: View {
    
    let text:String

    var body: some View {
        HStack(alignment: .top){
            Text("• ")
            Text(text)
        }
//        Text("• " + text)
    }
}

struct BulletedText_Previews: PreviewProvider {
    static var previews: some View {
        BulletedText(text: "")
    }
}
