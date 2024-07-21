//
//  ShareButton.swift
//  swftUIPractice1
//
//  Created by a on 20.07.24.
//

import SwiftUI

struct ShareButton: View {
    var url: String = "htttps://www.swiftful-thinking.com"
    var body: some View {
        if let url = URL(string: url){
            ShareLink(item: url){
                VStack{
                    Image(systemName: "paperplane")
                        .font(.title)

                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundColor(.netflixWhite)
                .padding(8)
                .background(.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        ShareButton()
    }
}
