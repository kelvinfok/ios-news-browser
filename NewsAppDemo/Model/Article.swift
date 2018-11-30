//
//  Article.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

class Source: Codable {
    let id: String?
    let name: String
}

class Article: Codable {
    
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
}

class News: Codable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    class func get(page: Int, pageSize: Int?, completion: @escaping (News?) -> Void) {
        
        APIManager.shared.request(type: EndpointManager.topHeadlines(page: page, pageSize: pageSize),
                                  method: .get,
                                  completion: completion)
    }

}
