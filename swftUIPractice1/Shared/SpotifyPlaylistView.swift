//
//  SpotifyPlaylistView.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    @State var products: [Product] = []
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            ScrollView{
                LazyVStack(spacing: 12){
                    PlaylistHeaderCell(title: product.title, subTitle: product.brand ?? "", imageName: product.firstImage, height: 250)
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: "\(user.firstName) " + "\(user.lastName)",
                        subheadline: product.category,
                        onAddToPlayListPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageName: product.firstImage,
                            songName: product.title,
                            artist: product.brand ?? "",
                            imageSize: 50,
                            onCellPressed: nil,
                            onEllipsisPressed: nil
                        )
                    }
                    .padding(.leading, 10)
                }
            }
        }
        .task{
            await self.loadData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func loadData() async {
        do{
            self.products = try await DatabaseHelper().getProducts()
            print("load products: \(products.count)")
        }catch{
            print("Error getting Users or products \(error)")
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
