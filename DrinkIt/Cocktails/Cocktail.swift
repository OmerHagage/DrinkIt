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
    
    init(id: String, uncommonIngredients: [String], uncommonQuantities: [Double], uncommonQuantitiesTypes: [String], commonIngredients: [String], commonQuantities: [Double], commonQuantitiesTypes: [String], garnish: [String],
         glassKind: String, recipe: [String], summary: String, rating:Int) {
        self.id = id
        self.uncommonIngredients = uncommonIngredients
        self.uncommonQuantities = uncommonQuantities
        self.uncommonQuantitiesTypes = uncommonQuantitiesTypes
        self.commonIngredients = commonIngredients
        self.commonQuantities = commonQuantities
        self.commonQuantitiesTypes = commonQuantitiesTypes
        self.garnish = garnish
        self.glassKind = glassKind
        self.recipe = recipe
        self.summary = summary
        self.rating = rating
    }
    
    init() {
        self.init(id: "", uncommonIngredients: [], uncommonQuantities: [], uncommonQuantitiesTypes: [], commonIngredients: [], commonQuantities: [], commonQuantitiesTypes: [], garnish: [], glassKind: "", recipe: [], summary: "", rating: 0)
    }
}
