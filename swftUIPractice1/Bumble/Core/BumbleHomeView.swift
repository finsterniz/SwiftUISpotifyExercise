//
//  BumbleHomeView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI

struct BumbleHomeView: View {
    @State var filters = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        ZStack{
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12){
                header
                
                BombleFilterView(options: filters, selection: $selectedFilter)
                    .background(
                    Divider(),
                    alignment: .bottom
                    )
                
                Spacer()
            }
        }
        .padding(8)
    }
    
    private var header: some View{
        HStack(spacing: 0){
            HStack(spacing: 0){
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .asButton {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .asButton {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundColor(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .asButton {
                    
                }
        }
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    BumbleHomeView()
}
