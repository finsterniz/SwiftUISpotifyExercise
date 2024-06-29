//
//  User.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import Foundation
struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable{
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock = User(
        id: 1,
        firstName: "John",
        lastName: "Doe",
        maidenName: "Smith",
        age: 30,
        email: "john.doe@example.com",
        phone: "+1-555-555-5555",
        username: "johndoe",
        password: "securepassword123",
        image: "https://example.com/images/johndoe.jpg",
        height: 180.5,
        weight: 75.0
    )
}
