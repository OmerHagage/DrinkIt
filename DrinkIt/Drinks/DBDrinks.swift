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
    private let dbCollection = Firestore.firestore().collection("drinks")
    
//    @Published var data = [Drink]()
//    @Published var data = Dictionary<String , [Drink]>()
    @Published var data:[String : [Drink]] = [:]

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
                
                var i = 0
                
                
                 for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                   
                    // add drink from db to array
//                    let category = document.data()["Category"] as! String
                    let category = ["Whisky","Gin","Rum"][i%3]
                    i+=1
                    
                    //todo: לבדוק אם זה מספיק מהיר
                    if (self.data.keys.contains(category)){
                        self.data[category]!.append(Drink(id: document.documentID, summary: document.data()["summary"] as! String, category: category))
                    }
                    else{
                        self.data[category] = [Drink(id: document.documentID, summary: document.data()["summary"] as! String, category: category)]
                    }
                    
                    
                    // add drink from db to array
//                    self.data.append(Drink(id: document.documentID, summary: document.data()["summary"] as! String))
                 }
             }
         }
    }
}
