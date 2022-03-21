//
//  Model.swift
//  GameStream
//
//  Created by ANA on 3/20/22.
//

import Foundation

struct Results:Codable {
    
    
    var results:[Game]
    
}

struct Games:Codable {
    
    var games: [Game]
    
}

struct Game:Codable, Hashable {
    
    var title:String
    var studio:String
    var contentRaiting:String
    var publicationYear:String
    var description:String
    var platforms:[String]
    var tags:[String]
    var videosUrls:videoUrl
    var galleryImages:[String]
    
}

struct videoUrl:Codable, Hashable{
    
    var mobile:String
    var tablet:String
    
}
