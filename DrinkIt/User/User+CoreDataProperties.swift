//
//  User+CoreDataProperties.swift
//  
//
//  Created by Omer Hagage on 13/09/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userDrinks: [String]?
    @NSManaged public var userFavoriteCocktails: [String]?

}
