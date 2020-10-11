//
//  DBImages.swift
//  DrinkIt
//
//  Created by Omer Hagage on 08/10/2020.
//  Copyright © 2020 Omer Hagage. All rights reserved.
//

import Foundation
import FirebaseStorage
import SDWebImage

//todo: אולי למחוק את כל זה 
class DBImages : ObservableObject {
    private let storageRef = Storage.storage().reference()
    
    var ima:UIImageView = UIImageView()
    
    
    
func cocktailImageRequest(cocktailName: String){
//        
    //var imaaaaa:UIImage = UIImage()
//        
//        
//        // Create a reference to the file you want to download
    let islandRef = storageRef.child("Cocktails/Martini.jpg")
//
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//    islandRef.downloadURL{ url, error in
//        if  error != nil {
////            // Uh-oh, an error occurred!
//            print(error ?? "beiza")
//        }
//        else {
//            print(url)
////           // Data for "images/island.jpg" is returned
//            print("----------------------------------bla------------------------")
//            URLSession.shared.dataTask(with: url!){ data, response, error in
//                guard let data = data, let image = UIImage(data: data) else {return}
//                RunLoop.main.perform {
//                    self.ima = image
//                }
//            }.resume()
//          }
//        }

//    return self.ima
    
    // Reference to an image file in Firebase Storage
    let reference = storageRef.child("Cocktails/Martini.jpg")

    // UIImageView in your ViewController
    let imageView: UIImageView = self.ima

    // Placeholder image
    let placeholderImage = UIImage(named: "placeholder.jpg")

    
    // Load the image using SDWebImage
    self.ima.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/drinkit-99b72.appspot.com/o/Cocktails%2FMartini.jpg?alt=media&token=7b64efff-6276-4128-92d0-44666537d5a8")!, placeholderImage: placeholderImage)
        
        
    }
    
//    func drinkImageRequest(cocktailName: String) -> <#return type#> {
//        <#function body#>
//    }
}



struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .colorInvert()
            .frame(width: 60, height: 60)
            .shadow(color: .white, radius: 1)
    }
    
    static var defaultImage = UIImage(named: "cocktail_icon")
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlString: nil)
    }
}


import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            print("Cache hit")
            return
        }
        
        print("Cache miss, loading from url")
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
