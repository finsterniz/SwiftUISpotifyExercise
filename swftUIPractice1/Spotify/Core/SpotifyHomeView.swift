//
//  SpotifyHomeView.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var showListSheet: Bool = false
    @State private var showPlaySheet: Bool = false
    
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
                        
                        ForEach(1..<20){_ in
                            Rectangle()
                                .foregroundColor(.red)
                                .frame(width: 200, height: 200)
                                
                        }
                    } header: {
                        header
                    }
                })
            }
            .padding(.top, 8)
            .clipped()
            .sheet(isPresented: $showListSheet, content: {
                Text("ListSheet")
                Button("dismiss"){
                    self.showListSheet = false
                }            })
            .sheet(isPresented: $showPlaySheet, content: {
                Text("PlaySheet")
                Button("dismiss"){
                    self.showPlaySheet = false
                }
            })
        }
        .task {
            await loadData()
        }
        .toolbar(.hidden, for: .navigationBar)
            
    }
    
    private func loadData() async {
        do{
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
        }catch{
            print("Error getting Users or products \(error)")
        }
    }
    
    private var recentsSection: some View{
        NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: products) { product in
            if let productImage = product?.firstImage, let title = product?.title{
                SpotifyRecentsCell(imageName: productImage, title: title)
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
            onAddToPlaylistPressed: {self.showListSheet = true},
            onPlayPressed: {self.showPlaySheet = true}
            )
    }
    
    private var header: some View{
        HStack(spacing: 0){
            ZStack{
                if let currentUser{
                    ImageLoaderView(urlString: currentUser.image)
                        .background(Color(.spotifyWhite))
                        .clipShape(Circle())
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
    SpotifyHomeView()
}
