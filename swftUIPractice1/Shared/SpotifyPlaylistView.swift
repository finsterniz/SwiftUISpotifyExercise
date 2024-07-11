//
//  SpotifyPlaylistView.swift
//  swftUIPractice1
//
//  Created by a on 29.06.24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    @State var products: [Product] = []
    @State var showHeader: Bool = true
    @Environment (\.router) var router
    
    var body: some View {
        ZStack(){
            Color.black.ignoresSafeArea()
            
            ScrollView{
                LazyVStack(spacing: 12){
                    PlaylistHeaderCell(title: product.title, subTitle: product.brand ?? "", imageName: product.firstImage, height: 250)
                        .readingFrame { frame in
                            showHeader = frame.maxY < 130
                        }
                    
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
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: nil
                        )
                        .asButton {
                            
                        }
                    }
                    .padding(.leading, 10)
                }
            }
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task{
            await self.loadData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func loadData() async {
        do{
            self.products = try await DatabaseHelper().getProducts()
        }catch{
            print("Error getting Users or products \(error)")
        }
    }
    
    private var header: some View{
        ZStack{
            Text(product.title)
                .padding(.vertical, 16)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .background(showHeader ? .spotifyBlack : .clear)
                .offset(y: showHeader ? 0 : -50)
                .opacity(showHeader ? 1.0 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showHeader ? .spotifyGray.opacity(0.001) : .spotifyGray.opacity(0.7))
                .clipShape(Circle())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .asButton {
                    router.dismissScreen()
                }
        }
        .foregroundColor(.spotifyWhite)
        .animation(.smooth(duration: 0.4), value: showHeader)
    }
    
    private func goToPlaylistView(product: Product){
        router.showScreen(.push){_ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
}

#Preview {
    RouterView{_ in
        SpotifyPlaylistView()
    }
}
