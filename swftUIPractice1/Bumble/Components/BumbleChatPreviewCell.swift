//
//  BumbleChatPreviewCell.swift
//  swftUIPractice1
//
//  Created by a on 03.07.24.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    var userName: String = "Terry"
    var latestMessage: String? = "This is a sentence about me that will"
    var hasYourMove: Bool = true
    
    var body: some View {
        HStack(spacing: 16){
            BumbleProfileImageCell()
            
            VStack(alignment: .leading, spacing: 2){
                HStack(spacing: 0){
                    Text(userName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InterestPillView(iconName: nil, emoji: nil, text: "YOUR MOVE", backgroundColor: .bumbleYellow)
                }
                
                if let latestMessage{
                    Text(latestMessage)
                        .font(.subheadline)
                        .foregroundColor(.bumbleGray)
                        .padding(.trailing, 16)
                }
            }
            .lineLimit(1)

        }
        
    }
}

#Preview {
    VStack{
        BumbleChatPreviewCell()
        BumbleChatPreviewCell()
        BumbleChatPreviewCell()
        BumbleChatPreviewCell()
    }
        .padding()
}
