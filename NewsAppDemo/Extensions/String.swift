//
//  String.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

import UIKit

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    
    var iso8601: Date? {
        return Formatter.Date.iso8601.date(from: self)
    }
}
