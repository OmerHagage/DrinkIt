//
//  DBDrinks.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation
import FirebaseFirestore





class DBDrinks: ObservableObject {

    let dbCollection = Firestore.firestore().collection("drinks")
    
    @Published var data = [Drink]()

    
    init() {
        addDrinksFromDB()
    }
    
    func addDrinksFromDB(){

        dbCollection.getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                
                    self.data.append(Drink(id: document.documentID))
                 }
             }
         }
//
        
        
        
//         dbCollection.addSnapshotListener { (documentSnapshot, err) in
//                          if err != nil {
//                              print((err?.localizedDescription)!)
//                              return
//                          }else {
//                              print("read data success")
//                          }
//
//                          documentSnapshot!.documentChanges.forEach { diff in
//                              // Real time create from server
//                              if (diff.type == .added) {
//                               let drink = DrinkView(id: diff.document.documentID, name: diff.document.get("name") as! String)
//                                  self.data.append(drink)
//                              }
//
//                              // Real time modify from server
//                              if (diff.type == .modified) {
//                                  self.data = self.data.map { (eachData) -> DrinkView in
//                                      var data = eachData
//                                      if data.id == diff.document.documentID {
//                                          data.name = diff.document.get("name") as! String
//                                          return data
//                                      }else {
//                                          return eachData
//                                      }
//                                  }
//                              }
//                          }
//                      }
    }
    
}
