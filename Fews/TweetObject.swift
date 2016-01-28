//
//  TweetObject.swift
//  Fews
//
//  Created by Audric Pandelé on 28/01/2016.
//  Copyright © 2016 Audric Pandelé. All rights reserved.
//

import UIKit

class TweetObject: NSObject {
    var text: String!
    var user_name: String!
    
    init(text: String, user_name: String){
        self.text = text
        self.user_name = user_name
    }
    
}