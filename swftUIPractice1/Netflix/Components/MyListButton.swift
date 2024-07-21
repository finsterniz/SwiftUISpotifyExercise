//
//  MyListButton.swift
//  swftUIPractice1
//
//  Created by a on 20.07.24.
//

import SwiftUI

struct MyListButton: View {
    var isInMyList: Bool = false
    var onButtonPressed: (()->Void)? = nil
    var body: some View {
        VStack{
            ZStack{
                Image(systemName: "checkmark")
                    .opacity(isInMyList ? 1 : 0)
                    .rotationEffect(Angle(degrees: isInMyList ? 0 : 180))
                
                Image(systemName: "plus")
                    .opacity(isInMyList ? 0 : 1)
                    .rotationEffect(Angle(degrees: isInMyList ? -180 : 0))
            }.font(.title)
                
            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .animation(.bouncy, value: isInMyList)
        .foregroundColor(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            onButtonPressed?()
        }
    }
}

fileprivate struct MyListButtonPreview: View{
    @State private var isInMyList: Bool = false
    var body: some View{
        MyListButton(
            isInMyList: isInMyList,
            onButtonPressed: {isInMyList.toggle()}
        )
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        
        MyListButtonPreview()
    }
}
