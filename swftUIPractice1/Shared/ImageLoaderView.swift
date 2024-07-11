//
//  ImageLoaderView.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString = Constants.randomImage
    var resizingMode: ContentMode? = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity) // 在图片加载的时候显示正在加载的圈圈
                    .aspectRatio(contentMode: resizingMode ?? .fill)
                    .allowsHitTesting(false) // 让图片无法点击, 不然哪怕clipped, 点击被clipped的空白部分还是会产生点击
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(30)
        .padding(.vertical, 60)
}
