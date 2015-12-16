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
    
    func JsonToEventsList(eventList: EventsList) -> EventsList {
        if let events = self.readableJSON.array {
            for event in events {
                let e = JsonToEvent(event)
                eventList.add(e)
            }
        }
        return eventList
    }
    
    func JsonToEvent(event: JSON) -> Event {
        let articles: [Article] = JsonToArticlesList(event)
        let topImage: TopImage = JsonToTopImage(event)
        let imagesList: [String] = JsonToImages(event)
        
        let event: Event = Event(id: event["_id"].string!, timestamp: event["timestamp"].string!, articles: articles, top_image: topImage, images: imagesList)
        return event
    }

    func JsonToArticlesList(event: JSON) -> [Article] {
        var articles: [Article] = []
        if let articleArray = event["articles"].array {
            for a in articleArray {
                let article: Article = Article(name: a["name"].string!, origin: a["origin"].string!, title: a["title"].string!, link: a["link"].string!, logo: a["logo"].string!)
                articles.append(article)
            }
        }
        return articles
    }
    
    func JsonToTopImage(event: JSON) -> TopImage {
        return TopImage(low: event["top_image"]["low"].string!, original: event["top_image"]["original"].string!)
    }
    
    func JsonToImages(event: JSON) -> [String] {
        var imagesList: [String] = []
        if let imageArray = event["images"].array {
            for image in imageArray {
                imagesList.append(image.string!)
            }
        }
        return imagesList
    }

    func addToJson(data: NSData){
        self.readableJSON = JSON(self.readableJSON.arrayObject! + JSON(data: data).arrayObject!)
    }
}
