//
//  DBDrinks.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import FirebaseFirestore

class DBDrinks: ObservableObject {

    // firestor db reference
    let dbCollection = Firestore.firestore().collection("drinks")
    
    @Published var data = [Drink]()

    /**
        read all the drinks from the db and save them
     */
    init() {
        addDrinksFromDB()
    }
    
    
    func addDrinksFromDB(){
        dbCollection.getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                   
                    // add drink from db to array
                    self.data.append(Drink(id: document.documentID, summary: document.data()["summary"] as! String))
                 }
             }
         }
    }
}
