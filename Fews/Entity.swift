//
//  JSONEntity.swift
//  Fews
//
//  Created by Clément Quennesson on 12/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON

class Entity: NSObject {
    
    var path: String!
    var jsonData: NSData!
    var readableJSON: JSON!
    
    init(path: String){
        super.init()
        self.path = path
        self.jsonData = NSData(contentsOfFile: path) as NSData!
        self.readableJSON = JSON(data: self.jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
    }
    
    func countImagesSources(index: Int) -> Int{
        return self.readableJSON[index]["sources"].count
    }
}
