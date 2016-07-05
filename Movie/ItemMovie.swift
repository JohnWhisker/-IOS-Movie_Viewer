//
//  ItemMovie.swift
//  Movie
//
//  Created by John Whisker on 7/5/16.
//  Copyright © 2016 John Whisker. All rights reserved.
//

import UIKit

class movie {
    var adult: Int?
    var title: String?
    var overview: String?
    var background: String?
    var releaseDate: String?
    var id: NSNumber?
    var originalLang: String?
    var video: Int?
    var vote_average: NSNumber?
    var vote_count: NSNumber?
    internal var lowResUrl: NSURL?
    internal var highResURL: NSURL?
    internal func initData(data: NSDictionary?){
        guard data != nil else {
            return;
        }
        self.title = data!["title"] as? String
        self.overview = data!["overview"] as? String
        self.background = data!["poster_path"] as? String
        self.adult = data!["adult"] as? Int
        self.releaseDate = data!["release_date"] as? String
        self.id = data!["id"] as? NSNumber
        self.vote_average = data!["vote_average"] as? NSNumber
        self.vote_count = data!["vote_count"] as? NSNumber
        self.originalLang = data!["original_language"] as? String
    }
    internal func printOut(){
        print("Title: \(self.title! as String )",
              "\n\nInfo: \(self.overview! as String )\n",
              "\nPath: \(self.background! as String )\n",
              "\nRelease Date: \(self.releaseDate! as String)\n",
              "\nLanguage: \((self.originalLang?.uppercaseString)! as String)\n",
              "\nID: \((self.id?.stringValue)! as String)\n",
              "\nIMDB: \((self.vote_average?.stringValue)! as String)\n",
              "\nVote Count: \((self.vote_count?.stringValue)! as String)\n",
              "\nFor adult: \(self.adult! as Int)\n\n\n")
     }
    
    internal func getURL(isHigh:Bool)->NSURL{
        guard isHigh else {
            let imageBaseUrlLow: String  = "https://image.tmdb.org/t/p/w342"
            let retURL = NSURL(string: imageBaseUrlLow + self.background!)
            return retURL!
        }
        let imageBaseUrlHigh: String = "https://image.tmdb.org/t/p/original"
        let retURL = NSURL(string: imageBaseUrlHigh + self.background!)
        return retURL!
    }
    
}

