//
//  BumbleHeartView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI

struct BumbleHeartIcon: View {
    var body: some View {
        ZStack{
            Color.bumbleYellow
                .clipShape(Circle())
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    BumbleHeartIcon()
}
