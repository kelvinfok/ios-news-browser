//
//  ImageView.swift
//  NewsAppDemo
//
//  Created by Kelvin Fok on 30/11/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

extension UIImageView {
    
    
    func setImage(urlString: String?) {
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else { return }
        
        sd_setImage(with: url, completed: nil)
        
    }
    
}
