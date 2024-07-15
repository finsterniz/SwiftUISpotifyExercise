//
//  NetflixHeroCell.swift
//  swftUIPractice1
//
//  Created by a on 09.07.24.
//

import SwiftUI

struct NetflixHeroCell: View {
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var categories: [String] = ["Raunchy", "Romantic", "Comedy"]
    var onBackgroundPressed: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    var onMyListPressed:(()->Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom){
            ImageLoaderView(urlString: imageName, resizingMode: .fill)
            
            VStack(spacing: 16){
                if isNetflixFilm{
                    nfilmSection
                }
                
                Text(title)
                    .font(.system(size: 50, weight: .medium, design: .serif))
                    .fontWeight(.medium)
                    .padding(.vertical, 2)
                
                HStack{
                    ForEach(categories, id:\.self) { category in
                        Text(category)
                        if category != categories.last{
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                
                
                HStack(spacing: 15){
                    button(imageStr: "play.fill", title: "Play") {
                        onPlayPressed?()
                    }
                    button(imageStr: "plus", title: "My List", backgroundColor: Color.netflixBlack, foregroundColor: .netflixWhite) {
                        onMyListPressed?()
                    }
                }
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundColor(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8, contentMode: .fit)
        .background(.black.opacity(0.001))
        .asButton(scale: 0.985, opacity: 1, brightness: 0.3) {
            onBackgroundPressed?()
        }
    }
    
    private func button(imageStr: String, title: String, backgroundColor: Color? = .netflixWhite, foregroundColor: Color? = .netflixBlack, onbuttonPressed: (()->Void)? = nil)->some View{
        let buttonPressed: (()->Void)? = nil
        
        return RoundedRectangle(cornerRadius: 5)
            .frame(maxWidth: .infinity)
            .frame(height: 30)
            .foregroundColor(backgroundColor)
            .overlay(
                HStack{
                    Image(systemName: imageStr)
                    
                    Text(title)
                }
                    .foregroundColor(foregroundColor ?? .netflixBlack)
            )
            .asButton {
                buttonPressed?()
            }
    }
    
    private var nfilmSection: some View{
        
        HStack(spacing: 8){
            Text("N")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .foregroundColor(.red)
            
            Text("F I L M")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.netflixWhite)
        }
        
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
