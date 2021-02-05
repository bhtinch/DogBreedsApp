//
//  Breed.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import Foundation

struct BreedListObject: Codable {
    let message: [String]
    let status: String
}

struct SubBreedListObject: Codable {
    let message: [String]
    let status: String
}

struct SubBreedImagesObject: Codable {
    let message: [URL]
    let status: String
}
