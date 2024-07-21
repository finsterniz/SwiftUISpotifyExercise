//
//  NetflixDetailHeaderView.swift
//  swftUIPractice1
//
//  Created by a on 15.07.24.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailHeaderView: View {
    var imageName: String = Constants.randomImage
    var progress: Double = Double.random(in: 0...1)
    var onAirplayPressed: (()->Void)? = nil
    var onXMarkPressed: (()->Void)? = nil
    @State var maxWidth: CGFloat = .zero
    
    var body: some View {
        ZStack{
            ImageLoaderView(urlString: imageName, resizingMode: .fill)
            
            ZStack{
                VStack{
                    HStack(spacing: 30){
                        Image(systemName: "tv.badge.wifi")
                            .offset(y: 1)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.netflixWhite)
                            .padding(8)
                            .background(.netflixDarkGray)
                            .clipShape(Circle())
                            .frame(width: 10, height: 10)
                            .background(Color.black.opacity(0.001))
                            .asButton {
                                onAirplayPressed?()
                            }
                        
                        Image(systemName: "xmark")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.netflixWhite)
                            .padding(8)
                            .background(.netflixDarkGray)
                            .clipShape(Circle())
                            .frame(width: 10, height: 10)
                            .background(Color.black.opacity(0.001))
                            .asButton {
                                onXMarkPressed?()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.trailing, 15)
                    .padding(.top, 20)
                    
                    CustomProgressBar(
                        selection: progress,
                        range: 0...1,
                        backgroundColor: .netflixLightGray,
                        foregroundColor: .netflixRed,
                        cornerRadius: 2,
                        height: 4
                    )
                    .padding(.bottom, 4)
                    .animation(.linear, value: progress)
                }
            }
//            .frame(width: maxWidth,height: 180)
            
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        NetflixDetailHeaderView()
    }
}
