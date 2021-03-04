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
        //todo: להחליט!
//        addDrinksFromJson()
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
                    let category = document.data()["category"] as! String
                   
                    
                    //todo: לבדוק אם זה מספיק מהיר
                    if (self.data.keys.contains(category)){
                        self.data[category]!.append(Drink(id: document.documentID, category: category, volume: document.data()["volume"] as! Int, summary: document.data()["summary"] as! String))
                    }
                    else{
                        self.data[category] = [Drink(id: document.documentID, category: category, volume: document.data()["volume"] as! Int, summary: document.data()["summary"] as! String)]
                    }
                    
                    
                    // add drink from db to array
//                    self.data.append(Drink(id: document.documentID, summary: document.data()["summary"] as! String))
                 }
             }
         }
    }
    
    
    func addDrinksFromJson() {
        guard
            let jsonFile = Bundle.main.url(forResource: "drinks", withExtension: "json"),
            let data = try? Data(contentsOf: jsonFile),
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
            print("Error getting json drinks document")
            exit(EXIT_FAILURE)
        }
        let drinks = (json as! [String: Any])["drinks"] as! [[String : Any]]
        for drink in drinks {
            // add drink from db to array
            let category = drink["category"] as! String
           
            // chekc if the category already exists in the data
            if (self.data.keys.contains(category)){
                self.data[category]!.append(Drink(id: drink["name"] as! String, category: category, volume: drink["alcohol_percentage"] as! Int, summary: drink["summary"] as! String))
            }
            else{
                self.data[category] = [Drink(id: drink["name"] as! String, category: category, volume: drink["alcohol_percentage"] as! Int, summary: drink["summary"] as! String)]
            }
        }
    }
    
}
