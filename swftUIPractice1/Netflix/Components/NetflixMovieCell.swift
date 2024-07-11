//
//  NetflixMovieCell.swift
//  swftUIPractice1
//
//  Created by a on 09.07.24.
//

import SwiftUI

struct NetflixMovieCell: View {
    var title: String = "Product title"
    var isRecentlyAdded: Bool = Bool.random()
    var imageName: String = Constants.randomImage
    var topTenRanking: Int? = nil
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -5){
            if let topTenRanking{
                Text("\(topTenRanking)")
                    .font(.system(size: 80, weight: .medium, design: .serif))
                    .offset(y: 20)
            }
                
            
            ZStack(alignment: .bottom){
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing: 2){
                    Text(title)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .lineLimit(1)
                    
                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y: 2)
                        .lineLimit(1)
                        .fontWeight(.bold)
                        .font(.caption2)
                        .minimumScaleFactor(0.1) // 有了这个以后, 如果容器放不下这个字, 会将文字缩小. 但是不会小于原来大小的0.1
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
                .background(
                    LinearGradient(
                        colors: [
                            Color.netflixBlack.opacity(0),
                            Color.netflixBlack.opacity(0.3),
                            Color.netflixBlack.opacity(0.4),
                            Color.netflixBlack.opacity(0.4),
                                ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .frame(width: width, height: height)
        }
//        .background(.blue)
        .foregroundColor(.netflixWhite)

    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        ScrollView(.vertical) {
             VStack{
                 NetflixMovieCell(topTenRanking: Int.random(in: 1...10))
                 NetflixMovieCell(topTenRanking: Int.random(in: 1...10))
                 NetflixMovieCell(topTenRanking: Int.random(in: 1...10))
                 NetflixMovieCell(topTenRanking: Int.random(in: 1...10))
            }
        }
    }
}
