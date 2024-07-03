//
//  interestPillView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI

struct InterestPillView: View {
    var iconName: String? = "heart.fill"
    var emoji: String? = "😳"
    var text: String = "Graduate Degree"
    var backgroundColor: Color? = .bumbleLightYellow
    
    var body: some View {
        HStack(spacing: 4){
            if let iconName{
                Image(systemName: iconName)
            }else if let emoji{
                Text(emoji)
            }
            
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundColor(.bumbleBlack)
        .background(backgroundColor)
        .cornerRadius(32)
    }
}

#Preview {
    VStack{
        InterestPillView(iconName: nil)
        InterestPillView()
    }
}
