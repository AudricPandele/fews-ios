//
//  Article.swift
//  Fews
//
//  Created by Clément Quennesson on 15/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class Article: NSObject {

    var name: String!
    var title: String!
    var link: String!
    var logo: String!
    
    init(name: String, title: String, link: String, logo: String){
        self.name = name
        self.title = title
        self.link = link
        self.logo = logo
    }
}
