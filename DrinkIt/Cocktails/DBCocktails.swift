//
//  DB.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//
import Foundation

class DBCocktails: ObservableObject {
    
    @Published var data = [Cocktail]()
    
    /**
        read all the cocktails from the db and save them
     */
    init() {
        addCocktailsFromJson()
    }
    
    
    func addCocktailsFromJson() {
        guard
            let jsonFile = Bundle.main.url(forResource: "cocktails", withExtension: "json"),
            let data = try? Data(contentsOf: jsonFile),
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
            print("Error getting json cocktails document")
            exit(EXIT_FAILURE)
        }
        let cocktails = (json as! [String: Any])["cocktails"] as! [[String : Any]]
        for cocktail in cocktails {
            self.data.append(Cocktail(id: cocktail["name"] as! String,
                                uncommonIngredients: cocktail["uncommon_ingredients"] as! [String],
                                uncommonQuantities: cocktail["uncommon_quantities"] as! [Double],
                                uncommonQuantitiesTypes: cocktail["uncommon_quantity_types"] as! [String],
                                commonIngredients: cocktail["common_ingredients"] as! [String],
                                commonQuantities: cocktail["common_quantities"] as! [Double],
                                commonQuantitiesTypes: cocktail["common_quantity_types"] as! [String],
                                garnish: cocktail["garnish"] as! [String],
                                glassKind: cocktail["glass_kind"] as! String,
                                recipe: cocktail["recipe"] as! [String],
                                summary: cocktail["summary"] as! String,
                                rating: Int(round(cocktail["rating"] as! Double))))
        }
    }
}

