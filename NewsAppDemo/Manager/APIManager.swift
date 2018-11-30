//
//  APIManager.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit
import Alamofire


class APIManager {
    
    static let shared = APIManager()
    
    let session = Alamofire.SessionManager.default
    
    func request<T: Codable>(type: EndpointManager, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (T?) -> Void) {
        
        print(EndpointManager.getURL(type: type))
        
        session.request(EndpointManager.getURL(type: type),
                        method: method,
                        parameters: parameters,
                        encoding: JSONEncoding.default,
                        headers: nil).responseData { (response) in
                            var object: T?
                            switch response.result {
                            case .success(let data):
                                do {
                                    object = try JSONDecoder().decode(T.self, from: data)
                                } catch {
                                    print(error)
                                }
                                completion(object)
                            case .failure(let error):
                                print("Error", error.localizedDescription)
                            }
        }
    }
}


extension DateFormatter {
    static var articleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
