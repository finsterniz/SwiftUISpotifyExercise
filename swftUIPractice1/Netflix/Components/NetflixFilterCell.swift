//
//  NetflixFilterCell.swift
//  swftUIPractice1
//
//  Created by a on 06.07.24.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title: String = "Category"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4){
            Text(title)
            if isDropdown{
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.netflixDarkGray.opacity(isSelected ? 1 : 0))
                    
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                    
                
            }
        )
        .foregroundColor(.netflixLightGray)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        
        VStack{
            NetflixFilterCell(isDropdown: false)
            NetflixFilterCell(isDropdown: true, isSelected: true)
            NetflixFilterCell(isDropdown: false, isSelected: true)
            NetflixFilterCell(isDropdown: true, isSelected: false)
        }
    }
    
    
}
