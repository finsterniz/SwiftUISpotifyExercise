//
//  SpotifyNewReleaseCell.swift
//  swftUIPractice1
//
//  Created by a on 28.06.24.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "Now release from"
    var subheadline: String? = "Some artist"
    var title: String = "Some Playlist"
    var subtitle: String = "Single - title"
    var onAddToPlaylistPressed: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    
    var body: some View {
        VStack{
            HStack(spacing: 9){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    if let headline{
                        Text(headline)
                            .foregroundColor(.spotifyLightGray)
                            .font(.headline)
                    }
                    
                    if let subheadline{
                        Text(subheadline)
                            .font(.title2)
                            .foregroundColor(.spotifyWhite)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                VStack(alignment: .leading, spacing: 32){
                    VStack(alignment: .leading, spacing: 2){
                        Text(title)
                            .fontWeight(.semibold)
                            .foregroundColor(.spotifyWhite)
                        
                        Text(subtitle)
                            .foregroundColor(.spotifyLightGray)
                            .lineLimit(3)
                    }
                    
                    HStack{
                        Image(systemName: "plus.circle")
                            .foregroundColor(.spotifyWhite)
                            .font(.title3)
                            .padding(4)
                            .background(.black.opacity(0.001))
                            .offset(x: -4)
                            .onTapGesture {
                                onAddToPlaylistPressed?()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(.spotifyWhite)
                            .font(.title)
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 16)
                }
                .font(.callout)
            }
            .background(.spotifyBlack.opacity(0.001))
            .onTapGesture {
                onPlayPressed?()
            }
            .themeColor(isSelected: false)
            .cornerRadius(8)
            
        }
    }
}

#Preview {
    ZStack{
        Color(.spotifyBlack).ignoresSafeArea()
        
        SpotifyNewReleaseCell()
            .padding()
    }
}
