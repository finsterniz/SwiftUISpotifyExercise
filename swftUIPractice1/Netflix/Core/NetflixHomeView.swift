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
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top){
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 8,
                       content: {
                    Rectangle()
                        .frame(height: fullHeaderSize.height)
                        .opacity(0)
                    
                    if let heroProduct{
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: true,
                            title: heroProduct.title,
                            categories: [heroProduct.category.capitalized, heroProduct.brand ?? ""]) {
                                
                            } onPlayPressed: {
                                
                            } onMyListPressed: {
                                
                            }
                            .padding(24)
                    }
                    
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
                })
            }
            
            VStack{
                header
                
                NetflixFilterBarView(
                    onXmarkPressed: {selectedFilter = nil},
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    selectedFilter: $selectedFilter,
                    filters: $filters
                )
                .padding(.top, 16)
            }
            .background(.blue)
            .readingFrame { frame in
                fullHeaderSize = frame
            }
        }
        .foregroundColor(.netflixWhite)
        .task{
            await getData()
        }
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
