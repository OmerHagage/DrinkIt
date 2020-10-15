//
//  Cocktail.swift
//  DrinkIt
//
//  Created by Omer Hagage on 09/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation

struct Cocktail: Identifiable {
    // coctail name
    let id: String
    
    let uncommonIngredients: [String]
    let uncommonQuantities: [Double]
    let uncommonQuantitiesTypes: [String]
    
    let commonIngredients: [String]
    let commonQuantities: [Double]
    let commonQuantitiesTypes: [String]
    
    let garnish: [String]
    let glassKind: String
    
    let recipe: [String]
    
    let summary: String
    
    let rating:Int
}
