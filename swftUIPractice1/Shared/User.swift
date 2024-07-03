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

struct User: Codable, Identifiable, Hashable{
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    var work: String {
        "Junior iOS Developer"
    }
    
    var distance: Int{
        10
    }
    
    var education: String{
        "Ba. in HU"
    }
    
    var aboutMe: String{
        "This is a sentence about me that will look good on my profile"
    }
    
    var interests: [UserInterest]{[ UserInterest(iconName: "star.fill", emoji: "⭐️", text: "Astronomy"),
        UserInterest(iconName: "book.fill", emoji: "📚", text: "Reading"),
        UserInterest(iconName: "paintbrush.fill", emoji: "🎨", text: "Painting"),
        UserInterest(iconName: "music.note", emoji: "🎵", text: "Music"),
        UserInterest(iconName: "music.note", emoji: "🎵", text: "Music"),
        UserInterest(iconName: "leaf.fill", emoji: "🍃", text: "Nature")]}
    
    var basics: [UserInterest]{
        [
            UserInterest(iconName: "gamecontroller.fill", emoji: "🎮", text: "Gaming"),
            UserInterest(iconName: "bicycle", emoji: "🚴‍♂️", text: "Cycling"),
            UserInterest(iconName: "bicycle", emoji: "🚴‍♂️", text: "Cycling"),
            UserInterest(iconName: "camera.fill", emoji: "📷", text: "Photography"),
            UserInterest(iconName: "film.fill", emoji: "🎬", text: "Movies"),
            UserInterest(iconName: "fork.knife", emoji: "🍽", text: "Cooking")
        ]
    }
    
    var images: [String]{
        ["https://picsum.photos/600/600", "https://picsum.photos/500/500", "https://picsum.photos/700/700"]
    }
    
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
        image: Constants.randomImage,
        height: 180.5,
        weight: 75.0
    )
}
