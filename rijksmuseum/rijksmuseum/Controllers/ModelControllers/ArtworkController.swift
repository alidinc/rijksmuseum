//
//  ArtworkController.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 04/08/2021.
//

import Foundation
import UIKit.UIImage

class ArtworkController {
    
    static let cache = NSCache<AnyObject, UIImage>()
    
    static func fetchArtObjects(completion: @escaping (Result<[ArtObject], ArtObjectError>) -> Void) {
        
        guard let baseURL = Constants.baseURL else { return completion(.failure(.invalidURL))}
        let collectionURL = baseURL.appendingPathComponent(Constants.collectionEndpoint)
        
        var urlComponents = URLComponents(url: collectionURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: Constants.keyQueryName, value: Constants.apiKey), URLQueryItem(name: "p", value: "1"), URLQueryItem(name: "ps", value: "10000")]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidAPIKey))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let artObjects = topLevelObject.artObjects
                completion(.success(artObjects))
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImageForArtObjects(imageURL: String, completion: @escaping (Result<UIImage, ArtObjectError>) -> Void) {
        
        let cacheKey = NSString(string: imageURL)
        
        if let image = cache.object(forKey: cacheKey) {
            return completion(.success(image))
        }
        
        
        guard let finalURL = URL(string: imageURL) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(.success(image))
        }.resume()
    }
}
