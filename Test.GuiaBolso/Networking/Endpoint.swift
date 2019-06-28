//
//  Endpoint.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = R.string.networking.scheme()
        components.host = R.string.networking.host()
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
