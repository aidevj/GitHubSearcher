//
//  PictureCache.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/14/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class PictureCache {
    
    private let cache = NSCache<NSURL, NSData>()
    
    let session = URLSession(configuration: .default)
    let queue = DispatchQueue.init(label: "PictureCache", qos: .utility, attributes: .concurrent)
    
    func insert(_ url: URL, image: Data) {
        let object = NSData(data: image)
        if let url = NSURL(string: url.absoluteString) {
            queue.sync(flags: .barrier) {
                self.cache.setObject(object, forKey: url)
            }
        }
    }
    
    func get(_ url: URL, _ completion: @escaping (Data?) -> Void) {
        guard let urlKey = NSURL(string: url.absoluteString) else {
            completion(nil)
            return
        }
        queue.sync(flags: .barrier) {
            if let image = cache.object(forKey: urlKey) {
                let data = Data(referencing: image)
                completion(data)
                return
            }
        }
        
        completion(nil)
        
        session.dataTask(with: url) { (data, _, _) in
            if let data = data {
                self.queue.sync(flags: .barrier) {
                    self.cache.setObject(NSData(data: data), forKey: urlKey)
                }
            }
            completion(data)
        }.resume()
    }
    
}

extension PictureCache {
    
    func insert(_ url: URL, image: UIImage) {
        if let data = image.pngData() {
            insert(url, image: data)
        }
    }
    
    func get(url: URL, _ completion: @escaping (UIImage?) -> Void) {
        get(url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }
        
}
