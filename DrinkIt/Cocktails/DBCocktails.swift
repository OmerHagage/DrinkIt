//
//  DB.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Firebase
import FirebaseFirestore


//let firebaseData = FirebaseData()

class DBCocktails: ObservableObject {
    
    let dbCollection = Firestore.firestore().collection("cocktails")
    
    @Published var data = [Cocktail]()
    
    init() {
        
        addCocktailsFromDB()
        
        }
        
        
    func addCocktailsFromDB(){
        dbCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    

                    self.data.append(Cocktail(id: document.documentID, recipe: document.data()["recipe"] as! String,
                                              alcoholIngredients: document.data()["alcohol ingredients"] as! [String],
                                              alcoholQuantities: document.data()["alcohol quantities"] as! [Double],
                                              nonAlcoholIngredients: document.data()["non-alcohol ingredients"] as! [String],
                                              nonAlcoholQuantities: document.data()["non-alcohol quantities"] as! [Double],
                                              summary: document.data()["summary"] as! String))
                    
                }
                
            }
            
        }
        
        
        
        
//         dbCollection.addSnapshotListener { (documentSnapshot, err) in
//                   if err != nil {
//                       print((err?.localizedDescription)!)
//                       return
//                   }else {
//                       print("read data success")
//                   }
//
//                   documentSnapshot!.documentChanges.forEach { diff in
//                       // Real time create from server
//                       if (diff.type == .added) {
//                        print("\(diff.document.documentID) => \(diff.document.data())")
//                        let cocktail = Cocktails(id: diff.document.documentID, name: diff.document.get("name") as! String, ingredients: diff.document.get("Ingredients") as! String)
//                           self.data.append(cocktail)
//                       }
//
//                       // Real time modify from server
//                       if (diff.type == .modified) {
//                           self.data = self.data.map { (eachData) -> Cocktails in
//                               var data = eachData
//                               if data.id == diff.document.documentID {
//                                    data.name = diff.document.get("name") as! String
//                                    data.ingredients = diff.document.get("Ingredients") as! String
//                                   return data
//                               }else {
//                                   return eachData
//                               }
//                           }
//                       }
//                   }
//               }
    }







}

//class DBconnection: Identifiable{
//    var id = UUID.init()
//
//    //Refarence to data base
////    private let DataBaseRef = Database.database().reference().child("ab")
//
//    init() {
//        getdata()
//    }
////    let refHandle = database.observe(DataEventType.value, with: { (snapshot) in
////      let postDict = snapshot.value as? [String : AnyObject] ?? [:]
////      // ...
////    })
////
//
//    func getdata(){
//
//    let DataBaseRef = Database.database().reference().child("ab")
//
//    DataBaseRef.observe(.value, with: { snapshot in
//        for  val in snapshot.children {
//            if let valSnapShot = val as? DataSnapshot,
//                let dict = valSnapShot.value as? [String:Any] {
//                print(dict)
//                print("fkdlmdflkgmdfl")
//            }
//
//        }
//    })
//    }
//
//
//}
