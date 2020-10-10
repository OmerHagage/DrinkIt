//
//  DBImages.swift
//  DrinkIt
//
//  Created by Omer Hagage on 08/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation
import FirebaseStorage

class DBImages : ObservableObject {
    private let storageRef = Storage.storage().reference()
    
    func cocktailImageRequest(cocktailName: String) -> [UIImage] {
        
//        self.storageRef.child("Cocktails/\(cocktailName).png").getData(maxSize: 1 * 1024 * 1024) { data, error in
//            var image:UIImage
//            if let error = error {
//                print(error)
////                image = UIImage(contentsOfFile: "cocktail_icon")!
//            } else {
//              // Data for "images/island.jpg" is returned
//                image = UIImage(data: data!)!
//            }
//            return image
//
//          }
        
        var image = [UIImage]()
        
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("Cocktails/\(cocktailName).png")

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
            print(error)
          } else {
            // Data for "images/island.jpg" is returned
            image.append(UIImage(data: data!) ?? UIImage(named: "cocktail_icon")!)
            
          }
        }
         
        
        return image
        
    }
    
//    func drinkImageRequest(cocktailName: String) -> <#return type#> {
//        <#function body#>
//    }
}
