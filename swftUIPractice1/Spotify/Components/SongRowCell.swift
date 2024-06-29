//
//  SongRowCell.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI

struct SongRowCell: View {
    var imageName: String = Constants.randomImage
    var songName: String = "some products"
    var artist: String = "some artist"
    var imageSize: CGFloat = 50
    var onCellPressed: (()->Void)? = nil
    var onEllipsisPressed: (()->Void)? = nil
    
    var body: some View {
        HStack{
            HStack{
                ImageLoaderView(urlString: imageName)
                    .frame(width: imageSize, height: imageSize)
                
                VStack(alignment: .leading, spacing: 4){
                    Text(songName)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.spotifyWhite)
                        .lineLimit(1)
                    
                    Text(artist)
                        .font(.callout)
                        .foregroundColor(.spotifyLightGray)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.blue)
//            .background(.spotifyBlack.opacity(0.001))
            .asButton(.press) {
                onCellPressed?()
            }
            
            Image(systemName: "ellipsis")
                .padding(18)
                .foregroundColor(.spotifyWhite)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onEllipsisPressed?()
                }
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        VStack{
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
    }
}
