//
//  ArtworkError.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 04/08/2021.
//

import Foundation

enum ArtObjectError: LocalizedError {
    
    case invalidURL
    case invalidAPIKey
    case unableToDecode
    case noData
    case thrownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL is provided. Please contact us."
        case .invalidAPIKey:
            return "Invalid APIKey is provided. Please contact us."
        case .unableToDecode:
            return "Unable to decode the data from RijksMuseum API."
        case .noData:
            return "There's not any available data for this request."
        case .thrownError(let error):
            return "An error with a description of \(error.localizedDescription) got caught. Please contact us."
        }
    }
}
