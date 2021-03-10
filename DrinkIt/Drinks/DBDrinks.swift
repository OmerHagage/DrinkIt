//
//  DBDrinks.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//
import Foundation


class DBDrinks: ObservableObject {

    // [drink category name : [Drink]]
    @Published var data:[String : [Drink]] = [:]
    
    // [drink name : Drink]
    @Published var drinksDict:[String : Drink] = [:]

    /**
        read all the drinks from the db and save them
     */
    init() {
        addDrinksFromJson()
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
            
            let temp:Drink = Drink(id: drink["name"] as! String, category: drink["category"] as! String, volume: drink["alcohol_percentage"] as! Int, summary: drink["summary"] as! String)
           
            // chekc if the category already exists in the data
            if (self.data.keys.contains(temp.category)){
                self.data[temp.category]!.append(temp)
            }
            else{
                self.data[temp.category] = [temp]
            }
            
            // add drink to drinks dict
            drinksDict[temp.id] = temp
        }
    }
    
}
