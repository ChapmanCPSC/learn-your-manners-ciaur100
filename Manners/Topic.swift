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

final class Topic{
    var title: String
    var article: String
    var image: UIImage
    
    init(title: String, article: String, image:UIImage){
        self.title = title
        self.article = article
        self.image = image
    }
}