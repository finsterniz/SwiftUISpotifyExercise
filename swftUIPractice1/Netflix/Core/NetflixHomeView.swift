//
//  NetflixHomeView.swift
//  swftUIPractice1
//
//  Created by a on 06.07.24.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockData
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGRect = .zero
    @State private var scrollViewOffSet: Double = 0
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top){
            Color.netflixBlack.ignoresSafeArea()
            
            gradientLayer
            
            scrollViewLayer

            fullHeaderWithFilter
        }
        .foregroundColor(.netflixWhite)
        .task{
            await getData()
        }
    }
    
    private var gradientLayer: some View{
        ZStack{
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)], startPoint: .top, endPoint: .bottom)
            
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom)
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffSet * 0.75)))
        // 乘0.75可以让它比我们的拖动更慢一点
        // 用max(10, x)可以让它不至于创建高度为负数的frame
        .opacity(scrollViewOffSet < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffSet)
        .ignoresSafeArea()
    }
    
    private var scrollViewLayer: some View{
        ScrollViewWithOnScrollChanged(.vertical, showsIndicators: false) {
            VStack(spacing: 8,
                   content: {
                
                Rectangle()
                    .frame (height: fullHeaderSize.height)
                    .opacity(0)
                
                if let heroProduct{
                    heroCell(product: heroProduct)
                }
                
                categoryRows
            })
        } onScrollChanged: { origin in
            scrollViewOffSet = min(0, origin.y)
        }
    }
    
    private var fullHeaderWithFilter: some View{
        VStack{
            header
            
            if scrollViewOffSet > -30{
                NetflixFilterBarView(
                    onXmarkPressed: {selectedFilter = nil},
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    selectedFilter: $selectedFilter,
                    filters: $filters
                )
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
        }
        .padding(.bottom, 8)
        .background(
            ZStack{
                if scrollViewOffSet < -60{
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial) // 透明材料, 要加在rectangle上
                        .brightness(-0.2) // 让元素看起来更暗一点
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth(duration: 0.3), value: scrollViewOffSet)
//            .background(.blue)
        .readingFrame { frame in
            if fullHeaderSize == .zero{
                fullHeaderSize = frame
            }
        }
    }
    
    private var categoryRows: some View{
        LazyVStack(alignment: .leading){
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, productRow) in
                Text(productRow.title)
                    .font(.headline)
                    .padding(.horizontal,16)
                
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(Array(productRow.products.enumerated()), id: \.offset) { (index, product) in
                            NetflixMovieCell(
                                title: product.title,
                                isRecentlyAdded: product.isRecentlyAdded,
                                imageName: product.firstImage,
                                topTenRanking: rowIndex == 0 ? index + 1 : nil
                            )
                        }
                    }
                    .padding(.horizontal,16)
                }
            }
        }
    }
    
    private func heroCell(product: Product)-> some View{
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [product.category.capitalized, product.brand ?? ""]) {
                
            } onPlayPressed: {
                
            } onMyListPressed: {
                
            }
            .padding(24)
    }
    
    private func getData() async {
        do{
            guard productRows.isEmpty else{
                return
            }
            
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await Array(DatabaseHelper().getProducts())
            heroProduct = products.randomElement()
            var rows: [ProductRow] = []
            let brands = Set(products.map { $0.brand })
            for brand in brands{
                rows.append(ProductRow(title: brand?.capitalized ?? "", products: products))
            }
            productRows = rows
        }catch{
            print("Error getting Users or products \(error)")
        }
    }
    
    private var header: some View{
        VStack(spacing: 0){
            HStack(spacing: 0){
                Text("For you")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                
                HStack(spacing: 26){
                    Image(systemName: "tv.badge.wifi")
                        .onTapGesture {
                            
                        }
                    
                    Image(systemName: "magnifyingglass")
                        .onTapGesture {
                            
                        }
                }
                .font(.title2)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NetflixHomeView()
}
