//
//  PlaylistDescriptionCell.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText = "This is some mock product description that goes here"
    var userName: String = "Hao"
    var subheadline = "Some headline goes here"
    var onAddToPlayListPressed: (()->Void)? = nil
    var onDownloadPressed: (()->Void)? = nil
    var onSharePressed: (()->Void)? = nil
    var onEllipsisPressed: (()->Void)? = nil
    var onShufflePressed: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text(descriptionText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
            
            HStack(){
                Image(systemName: "applelogo")
                    .font(.title3)
                    .foregroundColor(.spotifyGreen)
                
                madeForYouSection
            }

            Text(subheadline)

            buttonsRow
            .offset(x: -9)
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundColor(.spotifyLightGray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
//        .background(.red)
    }
    
    private var madeForYouSection: some View{
        Text("Made for ")
        +
        Text(userName)
            .fontWeight(.bold)
            .foregroundColor(.spotifyWhite)
    }
    
    private var buttonsRow: some View{
        HStack(){
            HStack{
                Image(systemName: "plus.circle")
                    .padding(9)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.circle")
                    .padding(9)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(9)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "ellipsis")
                    .padding(9)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(){
                Image(systemName: "shuffle")
                    .foregroundColor(.spotifyGreen)
                    .font(.system(size: 24))
                
                Image(systemName: "play.circle.fill")
                    .foregroundColor(.spotifyGreen)
                    .font(.system(size: 46))
            }
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        PlaylistDescriptionCell()
    }
}
