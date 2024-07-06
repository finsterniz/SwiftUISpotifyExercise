//
//  BumbleChatView.swift
//  swftUIPractice1
//
//  Created by a on 06.07.24.
//

import SwiftUI
import SwiftfulUI

struct BumbleChatView: View {
    @State private var allUsers : [User] = []
    @Environment (\.router) var router
    
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                    .padding(16)
                
                matchQueueSection
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                recentChatSection
            }
            .navigationBarBackButtonHidden()
        }
        .task{
            await getData()
        }
    }
    
    private var recentChatSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Group{
                Text("Chats")
                    .fontWeight(.medium)
                +
                Text("(Recent)")
                    .foregroundColor(.bumbleGray)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.vertical){
                LazyVStack{
                    ForEach(allUsers){user in
                        BumbleChatPreviewCell(
                            userName: user.firstName,
                            image: user.images.randomElement() ?? Constants.randomImage,
                            percentageRemaining: Double.random(in: 0...1),
                            hasMessage: Bool.random(),
                            latestMessage: user.aboutMe,
                            isYourMove: Bool.random()
                        )
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private var matchQueueSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Group{
                Text("Match Queue ")
                    .fontWeight(.medium)
                +
                Text("(\(allUsers.count))")
                    .foregroundColor(.bumbleGray)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(allUsers){user in
                        BumbleProfileImageCell(
                            userImage: user.images.randomElement() ?? Constants.randomImage,
                            percentageRemaining: Double.random(in: 0...1),
                            hasMessage: Bool.random()
                        )
                    }
                }
                .padding(.leading, 16)
            }
            .frame(height: 100)
            .scrollIndicators(.hidden)
        }
    }
        
    
    private func getData() async {
        do{
            guard allUsers.isEmpty else{
                return
            }
            
            allUsers = try await DatabaseHelper().getUsers()
        }catch{
            print("Error getting Users \(error)")
        }
    }
    
    private var header: some View{
        
        HStack{
            Image(systemName: "line.horizontal.3")
                .frame(maxWidth: .infinity, alignment: .leading)
                .asButton {
                    router.dismissScreen()
                }
            
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
    }
}

#Preview {
    BumbleChatView()
}
