//
//  DBDrinks.swift
//  DrinkIt
//
//  Created by Omer Hagage on 07/09/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//
import Foundation


class DBDrinks: ObservableObject {

    @Published var data:[String : [Drink]] = [:]

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
