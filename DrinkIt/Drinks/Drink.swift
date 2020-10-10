//
//  Drink.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation


struct Drink: Identifiable, Hashable{
    // drink name
    let id: String
    
    let summary: String
    let category: String
    let volume: Int = 17
}
