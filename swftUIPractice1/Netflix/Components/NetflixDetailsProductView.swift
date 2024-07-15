//
//  NetflixDetailsProductView.swift
//  swftUIPractice1
//
//  Created by a on 15.07.24.
//

import SwiftUI

struct NetflixDetailsProductView: View {
    var title: String = "Moview Title"
    var isNew: Bool = true
    var release: String = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaption: Bool = true
    var isTopTen: Bool = true
    var description: String = "#6 in TV Shows Today"
    var descriptionText: String? = "This is the description for the title that is selected and it should go multiple lines"
    var castText: String? = "Cast: Hao, Your Name, Someone Else"
    var onPlayPressed: (()->Void)? = nil
    var onDownloadPressed: (()->Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading , spacing: 8){
            Text(title)
                .foregroundColor(.netflixWhite)
            
            HStack(){
                if isNew{
                    Text("New")
                        .foregroundColor(.green)
                }
                Text(release)
                    .foregroundColor(.netflixLightGray)
                
                if let seasonCount{
                    Text("\(seasonCount) Seasons")
                        .foregroundColor(.netflixLightGray)
                }
                
                if hasClosedCaption{
                    Image(systemName: "ellipsis.bubble")
                        .foregroundColor(.netflixLightGray)
                }
            }
            
            HStack{
                Rectangle()
                    .fill(.netflixRed)
                    .frame(width: 30, height: 30)
                    .overlay(
                        VStack(spacing: -2){
                            Text("TOP")
                                .font(.system(size: 8))
                                .fontWeight(.bold)
                            
                            Text("10")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                            .foregroundColor(.netflixWhite)
                    )
                
                Text(description)
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            
            VStack(spacing: 8){
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .brightness(-0.1)
                    .frame(height: 30)
                    .overlay(
                        HStack{
                            Image(systemName: "play.fill")
                            Text("Play")
                        }
                    )
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(.netflixDarkGray)
                    .brightness(0.1)
                    .brightness(-0.1)
                    .frame(height: 30)
                    .overlay(
                        HStack{
                            Image(systemName: "arrow.down.to.line")
                            Text("Download")
                        }
                            .foregroundColor(.netflixWhite)
                    )
            }
            
            Group{
                if let descriptionText{
                    Text(descriptionText)
                        .foregroundColor(.netflixWhite)
                }
                
                if let castText{
                    Text(castText)
                        .foregroundColor(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 40){
            NetflixDetailsProductView()
            NetflixDetailsProductView(isNew: false, seasonCount: nil, hasClosedCaption: false, isTopTen: false)
            NetflixDetailsProductView()
        }
    }
}
