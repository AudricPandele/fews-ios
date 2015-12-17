//
//  Entity.swift
//  Fews
//
//  Created by Clément Quennesson on 17/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class Entity: NSObject {

    var name: String!
    var source_name: String!
    var source_url: String!
    var text: String!
    
    init(name: String, source_name: String, source_url: String, text: String){
        self.name = name
        self.source_name = source_name
        self.source_url = source_url
        self.text = text
    }
}
