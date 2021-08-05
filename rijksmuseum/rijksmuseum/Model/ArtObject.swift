//
//  Artwork.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 04/08/2021.
//

import Foundation

// MARK: - TopLevelObject
struct TopLevelObject: Codable {
    let artObjects: [ArtObject]
}

// MARK: - ArtObject
struct ArtObject: Codable {
    let links: Weblinks
    let title: String
    let principalOrFirstMaker, longTitle: String
    let webImage: Image
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - Links
struct Weblinks: Codable {
    let web: String
}


