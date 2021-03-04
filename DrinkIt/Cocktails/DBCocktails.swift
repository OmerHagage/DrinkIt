//
//  DB.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import FirebaseFirestore

class DBCocktails: ObservableObject {
    
    // firestore db reference
    private let dbCollection = Firestore.firestore().collection("cocktails")
    
    @Published var data = [Cocktail]()
    
    /**
        read all the cocktails from the db and save them
     */
    init() {
        //todo: להחליט!
//        addCocktailsFromJson()
        addCocktailsFromDB()
        }
        
        
    func addCocktailsFromDB(){
        dbCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                    
                    // add cocktail from db to array
                    self.data.append(Cocktail(id: document.documentID,
                                        uncommonIngredients: document.data()["uncommon_ingredients"] as! [String],
                                        uncommonQuantities: document.data()["uncommon_quantities"] as! [Double],
                                        uncommonQuantitiesTypes: document.data()["uncommon_quantity_types"] as! [String],
                                        commonIngredients: document.data()["common_ingredients"] as! [String],
                                        commonQuantities: document.data()["common_quantities"] as! [Double],
                                        commonQuantitiesTypes: document.data()["common_quantity_types"] as! [String],
                                        garnish: document.data()["garnish"] as! [String],
                                        glassKind: document.data()["glass_kind"] as! String,
                                        recipe: document.data()["recipe"] as! [String],
                                        summary: document.data()["summary"] as! String,
                                        rating: Int(round(document.data()["rating"] as! Double))))
                }
            }
        }
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

