//
//  TweetObject.swift
//  Fews
//
//  Created by Pierre Brethes on 28/01/2016.
//  Copyright © 2016 Pierre Brethes. All rights reserved.
//

import UIKit

class TweetObject: NSObject {
    var text: String!
    var user_name: String!
    var name: String!
    var link: String!
    
    init(text: String, user_name: String, name: String, link: String){
        self.text = text
        self.user_name = user_name
        self.name = name
        self.link = link
    }
    
}