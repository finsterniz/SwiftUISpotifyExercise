//
//  NetflixDetailView.swift
//  swftUIPractice1
//
//  Created by a on 15.07.24.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailView: View {
    
    @Environment(\.router) var router
    
    var product: Product = .mock
    
    @State var progress: Double = Double.random(in: 0...1)
    @State var isMyList: Bool = false
    @State var products: [Product] = []
    var onXMarkPressed: (()->Void)? = nil
    
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
                    onXMarkPressed:{
                        router.dismissScreen()
                        onXMarkPressed?()
                    }
                )
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 16){
                        detailsProductSection
                        
                        buttonSection
                        
                        VStack(alignment: .leading,
                               content: {
                            Text("More like this")
                                .font(.headline)
                            
                            productGridSection
                        })
                        .foregroundStyle(.netflixWhite)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
    }
    
    private func onProductPressed(product: Product){
        router.showScreen(.sheet){_ in
            NetflixDetailView(product: product, onXMarkPressed: {})
        }
    }
    
    private var productGridSection: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                  alignment: .center,
                  spacing: 8,
                  pinnedViews: [],
                  content: {
            ForEach(products){product in
                NetflixMovieCell(
                    title: product.title,
                    isRecentlyAdded: product.isRecentlyAdded,
                    imageName: product.firstImage,
                    topTenRanking: nil,
                    onCellPressed: {onProductPressed(product: product)}
                )
            }
        })
    }
    
    
    private var detailsProductSection: some View{
        NetflixDetailsProductView(
            title: product.title,
            isNew: true,
            release: "2024",
            seasonCount: 4,
            hasClosedCaption: true,
            isTopTen: true,
            description: product.description,
            castText: "Cast: Hao, Your Name, Someone Else") {
                
            } onDownloadPressed: {
                
            }
            .padding(8)
    }
    
    private var buttonSection: some View{
        HStack(spacing: 32){
            MyListButton(
                isInMyList: isMyList) {
                    isMyList.toggle()
                }
            
            RateButton { selection in
                // do something with selection
            }
            
            ShareButton(url: "www.google.com")
        }
        .padding(.leading, 32)
    }
    
    private func getData() async {
        do{
            guard products.isEmpty else{
                return
            }
            
            products = try await Array(DatabaseHelper().getProducts())
        }catch{
        }
    }
}

#Preview {
    RouterView{_ in
        NetflixDetailView()
    }
}
