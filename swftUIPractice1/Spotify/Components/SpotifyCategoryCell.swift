//
//  SpotifyCategoryCell.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var name: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(name)
            .frame(minWidth: 35)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .themeColor(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View{
    func themeColor(isSelected: Bool)->some View{
        self
            .background(isSelected ? Color.spotifyGreen : .spotifyBlack)
            .foregroundColor(isSelected ? Color.spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack
        
        VStack(spacing: 40){
            SpotifyCategoryCell(name: "Title goes here")
            SpotifyCategoryCell(isSelected: true)
            SpotifyCategoryCell(name: "another sample", isSelected: true)
            SpotifyCategoryCell()
        }
    }
    .ignoresSafeArea()
}
