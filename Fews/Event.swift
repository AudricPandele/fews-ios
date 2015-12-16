//
//  Event.swift
//  Fews
//
//  Created by Clément Quennesson on 15/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON

class Event: NSObject {

    var id: String!
    var timestamp: String!
    var articles: [Article]!
    var top_image: TopImage!
    var images: [String]!
    
    init(id: String, timestamp: String, articles: [Article], top_image: TopImage, images: [String]){
        
        self.id = id
        self.timestamp = timestamp
        self.articles = articles
        self.top_image = top_image
        self.images = images
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
    
    // Retrieve the shorten article title in an event
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
