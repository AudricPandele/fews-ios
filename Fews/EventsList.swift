//
//  EventsList.swift
//  Fews
//
//  Created by Clément Quennesson on 15/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftDate

class EventsList: NSObject {
    static let sharedInstance = EventsList()
    
    var events: [Event]
    
    override init(){
        self.events = []
    }
    
    func shuffle(){
        self.events.sortInPlace({ $0.id.toDate(DateFormat.Custom("yyyyMMddHHmmss")) > $1.id.toDate(DateFormat.Custom("yyyyMMddHHmmss")) })
    }
    
    func find(index: Int) -> Event {
        if index <= self.lenght() {
            return self.events[index]
        } else {
            fatalError("Index out of range")
        }
    }
    
    func add(event: Event) -> Void{
        self.events.append(event)
    }
    
    func lenght() -> Int{
        return self.events.count
    }
    
}
