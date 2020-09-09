//
//  Drink.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation


struct Drink: Identifiable{
    var id: String
    var name: String
}

//
//class Drink : Hashable {
//
//    private let name: String
//    // add picture
//    //    var pic: Int
//
//
//    init(drinkName:String) {
//        self.name = tempName
//    }
//
////    var hashValue: Int {
////        return self.name.hashValue
////    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.name)
//    }
//
//    static func == (lhs: Drink, rhs: Drink) -> Bool {
//        return lhs.name == rhs.name
//    }
//
//}
