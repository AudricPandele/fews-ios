//
//  JSONEntity.swift
//  Fews
//
//  Created by Clément Quennesson on 12/12/15.
//  Copyright © 2015 Audric Pandelé. All rights reserved.
//

import UIKit
import SwiftyJSON

class JsonObject: NSObject {
    
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
        let textList: [String] = JsonToText(event)
        let quote: String = JsonQuote(event)
        let location: String = JsonLocation(event)
        let wikipedias: [WikipediaObject] = JsonToWikipediaProduct(event)
        let tweets: [TweetObject] = JsonToTweets(event)
        
        let event: Event = Event(id: event["_id"].string!, articles: articles, top_image: topImage, images: imagesList, text: textList, quote: quote, location: location, wikipedias: wikipedias, tweets: tweets)
        return event
    }

    func JsonToArticlesList(event: JSON) -> [Article] {
        var articles: [Article] = []
        if let articleArray = event["articles"].array {
            for a in articleArray {
                let article: Article = Article(name: a["origin"]["name"].string!, title: a["title"].string!, link: a["link"].string!, logo: "https://fews.io/static/img/websites/\(a["origin"]["name"].string!).jpg")
                articles.append(article)
            }
        }
        return articles
    }
    
    func JsonToText(event: JSON) -> [String] {
        var textList: [String] = []
        if let textArray = event["summary"].array {
            let tabSize = textArray.count
            let half = tabSize/2
            
            var sentences: [String] = []
            for t in textArray {
                sentences.append(t.string!)
            }
            
            let summary1 = sentences[0..<half]
            let summary2 = sentences[half..<tabSize]
            
            textList.append(ArrayToString(summary1))
            textList.append(ArrayToString(summary2))
        }
        return textList
    }
    
    func ArrayToString(myArray: ArraySlice<String>) -> String{
        var summary: String = ""
        for mystring in myArray {
            summary = "\(summary) \(mystring)"
        }
        return summary
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
    
    func JsonToTweets(event: JSON) -> [TweetObject]{
        var tweetsTab: [TweetObject] = []
        
        if let tweets = event["tweets"].array {
            for tweet in tweets {
                let new_tweet: TweetObject = TweetObject(text: tweet["text"].string!, user_name: tweet["username"].string!, name: tweet["name"].string!, link: tweet["link"].string!)
                
                tweetsTab.append(new_tweet)
            }
        }
        return tweetsTab

    }
    
    func JsonToWikipediaProduct(event: JSON) -> [WikipediaObject]{
        var wikipedias: [WikipediaObject] = []
        let default_photo = ""
        let default_twitter = ""
        
        if let products = event["products"].array {
            for product in products {
                if (product["source_name"] == "wikipedia"){
                    
                    let wikipedia: WikipediaObject = WikipediaObject(name: product["name"].string!, source_url: product["source_url"].string!, text: product["text"].string!, photo: default_photo, twitter: default_twitter)
                    wikipedias.append(wikipedia)
                }
            }
        }
        
        if let companies = event["companies"].array {
            for company in companies {
                if (company["source_name"] == "wikipedia"){
                    let wikipedia: WikipediaObject = WikipediaObject(name: company["name"].string!, source_url: company["source_url"].string!, text: company["text"].string!, photo: default_photo, twitter: default_twitter)
                    wikipedias.append(wikipedia)
                }
            }
        }
        
        if let peoples = event["people"].array {
            for people in peoples {
                if (people["source_name"] == "wikipedia"){
                    let wikipedia: WikipediaObject = WikipediaObject(name: people["name"].string!, source_url: people["source_url"].string!, text: people["text"].string!, photo: default_photo, twitter: default_twitter)
                    wikipedias.append(wikipedia)
                }
            }
        }
        
        if let organizations = event["organizations"].array {
            for organization in organizations {
                if (organization["source_name"] == "wikipedia"){
                    let wikipedia: WikipediaObject = WikipediaObject(name: organization["name"].string!, source_url: organization["source_url"].string!, text: organization["text"].string!, photo: default_photo, twitter: default_twitter)
                    wikipedias.append(wikipedia)
                }
            }
        }
        
        return wikipedias
    }
    
    func JsonQuote(event: JSON) -> String {
        return event["quotes"][0]["text"].string!
    }
    
    func JsonLocation(event: JSON) -> String {
        return event["locations"][0].string!
    }


    func addToJson(data: NSData){
        self.readableJSON = JSON(self.readableJSON.arrayObject! + JSON(data: data).arrayObject!)
    }
}
