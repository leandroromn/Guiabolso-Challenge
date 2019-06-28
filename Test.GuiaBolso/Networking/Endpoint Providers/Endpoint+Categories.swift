//
//  Endpoint+Categories.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

extension Endpoint {
    
    static func getCategories() -> Endpoint {
        return Endpoint(
            path: R.string.networking.categories_url(),
            queryItems: []
        )
    }
    
}
