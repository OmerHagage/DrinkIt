//
//  DrinkView.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import SwiftUI

struct DrinkView: View, Identifiable, Hashable{
    var id: String
    var name: String
    var bgColor:Color = Color.clear
    var selected:Bool = false
//    var image:Image = Image(systemName: "arkit")
    
    // delete the view
    var body: some View {
        HStack{
            Spacer()
            Text(self.name)
            Spacer()
            Image(systemName: "arkit")
            Spacer()
        }
    }
}

struct DrinkView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkView(id: "dsfk" , name: "jin")
    }
}
