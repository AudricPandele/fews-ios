//
//  WikipediaObject.swift
//  Fews
//
//  Created by Audric Pandelé on 20/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class WikipediaObject: NSObject {
    var name: String!
    var source_url: String!
    var text: String!
    var photo: String!
    var twitter: String!
    
    init(name: String, source_url: String, text: String, photo: String, twitter: String){
        self.name = name
        self.source_url = source_url
        self.text = text
        self.photo = photo
        self.twitter = twitter
    }
    
}
