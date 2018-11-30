//
//  EndpointManager.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

enum EndpointManager {
    
    static let base = "https://newsapi.org/"
    static let defaultPageSize = 5
    static let apiKey = Config.apiKey.fromBase64()!
    
    case topHeadlines(page: Int, pageSize: Int?)
    
    // https://newsapi.org/v2/top-headlines?country=sg&category=business&apiKey=81bc9466c0fa483c8f5115f08724641b&pagesize=1
    
    static func getURL(type: EndpointManager) -> URL {
        switch type {
        case .topHeadlines(let page, let pageSize):
            let path = "/v2/top-headlines?country=sg&category=business&apiKey=\(apiKey)&pagesize=\(pageSize ?? defaultPageSize)&page=\(page)"
            return createURL(path: path)
        }
    }
    
    static func createURL(path: String) -> URL {
        return URL(string: base + path)!
    }
    
}
