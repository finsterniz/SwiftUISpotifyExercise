//
//  SpotifyRecentsCell.swift
//  swftUIPractice1
//
//  Created by a on 28.06.24.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    var imageName : String = Constants.randomImage
    var title: String = "some image title"
    
    var body: some View {
        HStack{
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(title)
                .fontWeight(.semibold)
                .font(.callout)
                .lineLimit(2)
                .themeColor(isSelected: false)
                .padding(.trailing, 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack.ignoresSafeArea()
        
        VStack{
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            HStack{
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    }
}
