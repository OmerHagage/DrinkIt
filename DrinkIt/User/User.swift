//
//  User.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation

class User{
    
    var id: String
//    var drinks = [Drink]()
    var drinksList = Set<Drink>()
    
    init(UId:String) {
        self.id = UId
    }
    
    func addDrink(drink: Drink){
        drinksList.insert(drink)
    }
    
    func removeDrink(drink: Drink){
        drinksList.remove(drink)
    }
}
