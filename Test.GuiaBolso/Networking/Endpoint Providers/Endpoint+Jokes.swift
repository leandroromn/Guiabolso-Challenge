//
//  Endpoint+Jokes.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 28/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

extension Endpoint {
    
    static func getRandomJokeFor(category jokeCategory: String) -> Endpoint {
        return Endpoint(
            path: R.string.networking.jokes_url(),
            queryItems: [
                URLQueryItem(name: R.string.networking.category_query_param(), value: jokeCategory)
            ]
        )
    }
    
}
