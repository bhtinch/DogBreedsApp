//
//  NetworkError.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case thrownError(Error)
    case unableToDecode
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .noData:
            return "The server returned no data."
        case .thrownError(let error):
            return "Thrown Error: \(error.localizedDescription)"
        case .unableToDecode:
            return "Unable to decode JSON"
        }
    }
}
