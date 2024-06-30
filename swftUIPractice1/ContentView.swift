//
//  ContentView.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @Environment (\.router) var router
    
    var body: some View {
        Button("show spotify"){
            router.showScreen(.fullScreenCover){_ in
                SpotifyHomeView()
            }
        }
    }
}

#Preview {
    RouterView{_ in
        ContentView()
    }
}
