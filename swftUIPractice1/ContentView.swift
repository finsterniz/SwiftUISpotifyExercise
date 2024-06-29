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
    @State var users: [User] = []
    @State var products: [Product] = []
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(users) { user in
                    Text(user.firstName)
                }
            }
            .foregroundStyle(
                .spotifyGreen
            )
        }
        .padding()
        .task {
            await loadData()
        }
        
    }
    
    private func loadData() async {
        do{
            users = try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        }catch{
            print("Error getting Users or products \(error)")
        }
    }
}

#Preview {
    ContentView()
}
