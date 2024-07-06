//
//  BumbleProfileImageCell.swift
//  swftUIPractice1
//
//  Created by a on 03.07.24.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var userImage: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasMessage: Bool = true
    
    var body: some View {
        ZStack{
            ImageLoaderView(urlString: userImage)
                .clipShape(Circle())
                .padding(5)
            
            Circle()
                .stroke(.black, lineWidth: 3)
            
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
                .scaleEffect(x: -1, y: 1, anchor: .center) // mirror the circle
        }
        .frame(width: 75, height: 75)
        .overlay(
            ZStack(){
                if hasMessage{
                    Circle()
                        .fill(.bumbleWhite)
                    
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(4)
                }
            }
                .frame(width: 24)
            , alignment: .bottomTrailing
        )
        
    }
}

#Preview {
    VStack{
        BumbleProfileImageCell(percentageRemaining: 0.3)
        BumbleProfileImageCell(percentageRemaining: 0.4)
        BumbleProfileImageCell(percentageRemaining: 0.5)
        BumbleProfileImageCell(percentageRemaining: 0.6)
        BumbleProfileImageCell(percentageRemaining: 1)
        BumbleProfileImageCell(percentageRemaining: 0)
        BumbleProfileImageCell(hasMessage: false)
    }
}
