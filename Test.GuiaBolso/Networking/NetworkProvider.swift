//
//  NetworkProvider.swift
//  Test.GuiaBolso
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation
import PromiseKit

enum NetworkError: Error {
    case badUrl
    case unauthorized
    case forbidden
    case notFound
    case mappingError
    case emptyResponseDataError
    case unknownError
}

struct NetworkProvider {
    
    func request<T: Codable>(_ endpoint: Endpoint) -> Promise<T> {
        return Promise { seal in
            guard let url = endpoint.url else { return seal.reject(NetworkError.badUrl) }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return seal.reject(NetworkError.emptyResponseDataError) }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                
                if 200...299 ~= statusCode {
                    do {
                        let decodableObject = try JSONDecoder().decode(T.self, from: data)
                        return seal.fulfill(decodableObject)
                    } catch {
                        return seal.reject(NetworkError.mappingError)
                    }
                }
                
                return seal.reject(self.parseErrorFor(statusCode: statusCode))
            }.resume()
        }
    }
    
    fileprivate func parseErrorFor(statusCode: Int) -> NetworkError {
        if statusCode == 401 { return .unauthorized }
        if statusCode == 403 { return .forbidden }
        if statusCode == 404 { return .notFound }
        return .unknownError
    }
    
}
