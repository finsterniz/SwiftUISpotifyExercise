//
//  NetflixDetailView.swift
//  swftUIPractice1
//
//  Created by a on 15.07.24.
//

import SwiftUI

struct NetflixDetailView: View {
    
    var product: Product = .mock
    
    @State var progress: Double = Double.random(in: 0...1)
    
    var body: some View {
        ZStack{
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            
            VStack(spacing: 0){
                NetflixDetailHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed:{}
                )
            }
            
            
            ScrollView{
                
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NetflixDetailView()
}
