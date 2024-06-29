//
//  Product.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let images: [String]
    let thumbnail: String
    
    var firstImage: String{
        return images.first ?? Constants.randomImage
    }
}
