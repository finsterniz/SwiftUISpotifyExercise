//
//  ImageTitleRowCell.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageSize: CGFloat = 100
    var imageName: String = Constants.randomImage
    var title: String = "Some Item Name"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundColor(.spotifyWhite)
                .lineLimit(2)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack
            .ignoresSafeArea()
        
        ImageTitleRowCell()
    }
}
