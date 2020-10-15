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
}

