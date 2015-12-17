//
//  Event.swift
//  Fews
//
//  Created by Clément Quennesson on 15/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

class Event: NSObject {

    var id: String!
    var date: NSDate!
    var articles: [Article]!
    var top_image: TopImage!
    var images: [String]!
    var text: [String]!
    var location: String!
    
    init(id: String, articles: [Article], top_image: TopImage, images: [String], text: [String]){
        
        self.id = id
        self.date = id.toDate(DateFormat.Custom("yyyyMMddHHmmss"))!
        self.articles = articles
        self.top_image = top_image
        self.images = images
        self.text = text
        self.location = "27 rue huguerie"
    }
    
    func findArticle(index: Int) -> NSObject {
        return self.articles[index]
    }
    
    func addArticle(article: Article) -> Void{
        self.articles.append(article)
    }
    
    func NbArticles() -> Int{
        return self.articles.count
    }
    
    func prepareArticleShortenTitle() -> String {
        return articles.sort({ $0.title.characters.count < $1.title.characters.count })[0].title
    }
    
    func prepareEventShareUrl() -> String {
        return "https://fews.io/event/\(self.id)"
    }
    
    func shareEvent() -> String {
        return "Check out the event \(self.prepareEventShareUrl()) w/ @Fewsio"
    }
}
