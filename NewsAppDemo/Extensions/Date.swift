//
//  Date.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

extension Date {
    
    var iso8601: String {
        return Formatter.Date.iso8601.string(from: self)
    }
    
    func toNewsFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: self)
    }
    
}
