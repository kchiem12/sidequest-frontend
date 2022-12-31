//
//  ImageProvider.swift
//  sidequest1
//
//  Created by Ken Chiem on 12/23/22.
//

import UIKit

// Used to cache images and to improve performance
class ImageProvider {

    static let sharedCache = ImageProvider()
    
    // Utilizes NSCache
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // Returns an image from the cache if it exists, otherwise it downloads the image from the URL
    public func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
        // Checks if the image is already in the cache
        if let image = cache.object(forKey: url as NSString) {
            completion(image)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        
        // Obtains the image from the given URL
        // TODO: Refactor this. This exact same snippet of code is found in TestViewController.swift
        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: url as NSString)
                completion(image)
            }
        }
        task.resume()
    }

}
