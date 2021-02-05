//
//  SubBreedController.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import Foundation
import UIKit

class SubBreedController {
    static let baseURL = URL(string: "https://dog.ceo/api")
    static let breedListEndpoint = "breeds/list"
    static let breedComponent = "breed"
    static let listEndpoint = "list"
    static let imagesEndpoint = "images"
    
    static var images: [UIImage] = []
    
    static func fetchBreedList(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
        guard let baseURL = self.baseURL else { return completion(.failure(.invalidURL)) }
        let finalURL = baseURL.appendingPathComponent(breedListEndpoint)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let breedListObject = try JSONDecoder().decode(BreedListObject.self, from: data)
                let breedList = breedListObject.message
                completion(.success(breedList))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSubBreedList(ofBreed breed: String, completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let breedComponentURL = baseURL.appendingPathComponent(breedComponent)
        let breedURL = breedComponentURL.appendingPathComponent(breed)
        let finalURL = breedURL.appendingPathComponent(listEndpoint)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let subBreedListObject = try JSONDecoder().decode(SubBreedListObject.self, from: data)
                let subBreedList = subBreedListObject.message
                completion(.success(subBreedList))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSubBreedImageURLs(ofBreed breed: String, ofSubBreed subBreed: String, completion: @escaping (Result<[URL], NetworkError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let breedComponentURL = baseURL.appendingPathComponent(breedComponent)
        let breedURL = breedComponentURL.appendingPathComponent(breed)
        
        var subBreedURL: URL
        if breed == subBreed {
            subBreedURL = breedURL
        } else {
            subBreedURL = breedURL.appendingPathComponent(subBreed)
        }
        
        let finalURL = subBreedURL.appendingPathComponent(imagesEndpoint)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR 1========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let subBreedImagesObject = try JSONDecoder().decode(SubBreedImagesObject.self, from: data)
                let imageURLS = subBreedImagesObject.message
                completion(.success(imageURLS))
            } catch {
                print("======== ERROR 3========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSubBreedImage(withURL url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
               
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else { return completion(.failure(.noData)) }
            completion(.success(image))
        }.resume()
    }
}
