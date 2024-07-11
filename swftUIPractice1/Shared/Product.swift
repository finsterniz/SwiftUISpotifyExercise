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

struct Product: Codable, Identifiable {
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
    
    let isRecentlyAdded: Bool = {
        return Int.random(in: 1...4) == 1
    }()
    
    static var mock: Product{
        Product(
            id: 123,
            title: "Example product",
            description: "This is some mock product",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            category: "Eletronic Device",
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage],
            thumbnail: Constants.randomImage
        )
    }
}

struct ProductRow: Identifiable{
    let id = UUID().uuidString
    let title: String
    var products: [Product]
}
