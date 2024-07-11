//
//  PlaylistHeaderCell.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var title: String = "Some playlist title goes here"
    var subTitle: String = "Subtitle goes here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = Color.spotifyBlack.opacity(0.8)
    var height: CGFloat = 300
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8){
                    Text(subTitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundColor(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                )
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        ScrollView{
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
