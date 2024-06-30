//
//  swftUIPractice1App.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI
import SwiftfulRouting

@main
struct swftUIPractice1App: App {
    var body: some Scene {
        WindowGroup {
            RouterView{_ in
                SpotifyHomeView()
            }
        }
    }
}
