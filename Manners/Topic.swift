//
//  Topic.swift
//  Manners
//
//  Created by Stephen Ciauri on 4/18/16.
//  Copyright © 2016 Stephen Ciauri. All rights reserved.
//

import Foundation
import UIKit

// If I'm feeling adventurous, implement NSCoding

final class Topic: NSObject, NSCoding{
    var title: String
    var article: String
    var imageName: String
    var viewed: Bool
    
    init(title: String, article: String, image:String){
        self.title = title
        self.article = article
        self.imageName = image
        self.viewed = false
    }
    
    init(title: String, article: String, image: String, viewed: Bool){
        self.title = title
        self.article = article
        self.imageName = image
        self.viewed = viewed
    }
    
    
    /*
        NSCoding. 
    */
    required convenience init?(coder decoder: NSCoder){
        guard let title = decoder.decodeObjectForKey("title") as? String,
            let article = decoder.decodeObjectForKey("article") as? String,
            let imageName = decoder.decodeObjectForKey("imageName") as? String
            else {return nil}
        
        self.init(title: title,
                  article: article,
                  image: imageName,
                  viewed: decoder.decodeBoolForKey("viewed"))
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(article, forKey: "article")
        aCoder.encodeObject(imageName, forKey: "imageName")
        aCoder.encodeBool(viewed, forKey: "viewed")
    }
}