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
                    self.data.append(Cocktail(id: document.documentID, recipe: document.data()["recipe"] as! [String],
                                              alcoholIngredients: document.data()["alcohol ingredients"] as! [String],
                                              alcoholQuantities: document.data()["alcohol quantities"] as! [Double],
                                              nonAlcoholIngredients: document.data()["non-alcohol ingredients"] as! [String],
                                              nonAlcoholQuantities: document.data()["non-alcohol quantities"] as! [Double],
                                              summary: document.data()["summary"] as! String))
                }
            }
        }
    }
}
