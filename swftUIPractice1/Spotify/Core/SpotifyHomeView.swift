//
//  SpotifyHomeView.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
//    @State private var showListSheet: Bool = false
    @State private var showPlaySheet: Bool = false
    @State private var productRows: [ProductRow] = []
    @Environment (\.router) var router

    
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView{
                LazyVStack(spacing: 3,
                           pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack{
                            recentsSection
                            
                            if let product = products.first{
                                newReleaseSection(product: product)
                            }
                        }
                        .padding(.horizontal, 10)
                        
                        listRows
                    } header: {
                        header
                    }
                })
            }
            .padding(.top, 8)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
            
    }
    
    private func getData() async {
        do{
            guard products.isEmpty else{
                return
            }
            
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
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
    
    private var recentsSection: some View{
        NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: products) { product in
            if let productImage = product?.firstImage, let title = product?.title{
                SpotifyRecentsCell(
                    imageName: productImage,
                    title: title
                )
                .asButton(.press) {
                    guard let product else { return }
                    goToPlaylistView(product: product)
                }
        }
        }
    }
    
    private func newReleaseSection(product: Product) -> some View{
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {},
            onPlayPressed: {goToPlaylistView(product: product)}
            )
    }
    
    private var listRows: some View{
        ForEach(productRows) { productRow in
            VStack{
                Text(productRow.title)
                    .foregroundColor(.spotifyWhite)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal){
                    HStack(alignment: .top){
                        ForEach(productRow.products){product in
                            ImageTitleRowCell( imageName: product.firstImage, title: product.title)
                                .asButton(.press) {
                                    goToPlaylistView(product: product)
                                }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 9)
    }
    
    private func goToPlaylistView(product: Product){
        guard let currentUser else{
            return
        }
        
        router.showScreen(.push){_ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }
    
    private var header: some View{
        HStack(spacing: 0){
            ZStack{
                if let currentUser{
                    ImageLoaderView(urlString: currentUser.image)
                        .background(Color(.spotifyWhite))
                        .clipShape(Circle())
                        .asButton {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)

            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 6){
                    ForEach(Category.allCases, id: \.self){category in
                        SpotifyCategoryCell(name: category.rawValue.capitalized, isSelected: selectedCategory == category)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
            })
            .padding(.vertical, 20)
            .padding(.leading, 10)
        }
        .background(.black)
    }
}

#Preview {
    RouterView{_ in
        SpotifyHomeView()
    }
}
