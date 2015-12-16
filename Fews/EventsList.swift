//
//  EventsList.swift
//  Fews
//
//  Created by Clément Quennesson on 15/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit

class EventsList: NSObject {
    static let sharedInstance = EventsList()
    
    var events: [NSObject]
    
    override init(){
        self.events = []
    }
    
    func find(index: Int) -> NSObject {
        if index < self.lenght() {
            return self.events[index]
        } else {
            fatalError("Index out of range")
        }
    }
    
    func add(event: NSObject) -> Void{
        self.events.append(event)
    }
    
    func lenght() -> Int{
        return self.events.count
    }
    
}
