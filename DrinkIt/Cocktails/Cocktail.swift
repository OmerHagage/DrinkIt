//
//  Cocktail.swift
//  DrinkIt
//
//  Created by Omer Hagage on 09/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation

struct Cocktail: Identifiable {
    let id: String
    let recipe: [String]
    let alcoholIngredients: [String]
    let alcoholQuantities: [Double]
    let nonAlcoholIngredients: [String]
    let nonAlcoholQuantities: [Double]
    let summary: String

}
