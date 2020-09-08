//
//  DB.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Firebase
import FirebaseFirestore

let dbCollection = Firestore.firestore().collection("cocktails")
let firebaseData = FirebaseData()

class FirebaseData: ObservableObject {
    
    @Published var data = [Cocktails]()
    
    init() {
         dbCollection.addSnapshotListener { (documentSnapshot, err) in
                   if err != nil {
                       print((err?.localizedDescription)!)
                       return
                   }else {
                       print("read data success")
                   }
                   
                   documentSnapshot!.documentChanges.forEach { diff in
                       // Real time create from server
                       if (diff.type == .added) {
                        let cocktail = Cocktails(id: diff.document.documentID, name: diff.document.get("id") as! String ,msg: diff.document.get("name") as! String)
                           self.data.append(cocktail)
                       }
                       
                       // Real time modify from server
                       if (diff.type == .modified) {
                           self.data = self.data.map { (eachData) -> Cocktails in
                               var data = eachData
                               if data.id == diff.document.documentID {
                                   data.msg = diff.document.get("name") as! String
                                   data.name = diff.document.get("id") as! String
                                   return data
                               }else {
                                   return eachData
                               }
                           }
                       }
                   }
               }
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
