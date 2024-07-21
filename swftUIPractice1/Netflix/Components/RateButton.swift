//
//  RateButton.swift
//  swftUIPractice1
//
//  Created by a on 20.07.24.
//

import SwiftUI

enum RateOption: String, CaseIterable{
    case disliek, like, love
    
    var title: String{
        switch self{
        case .disliek:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "Love this!"
        }
    }
    
    var iconName: String{
        switch self{
        case .disliek:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopOver: Bool = false
    var onRatingSelected: ((RateOption)->Void)? = nil
    
    var body: some View {
        VStack{
            Image(systemName: "hand.thumbsup")
                .font(.title)

            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundColor(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopOver.toggle()
        }
        .popover(isPresented: $showPopOver, content: {
            ZStack{
                Color.netflixDarkGray.ignoresSafeArea()
                HStack(spacing: 12){
                    ForEach(RateOption.allCases, id: \.self){option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            .presentationCompactAdaptation(.popover)
        })
    }
    
    private func rateButton(option: RateOption)->some View{
        VStack(spacing: 10){
            Image(systemName: option.iconName)
                .font(.title2)
            Text("\(option.title)")
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopOver = false
            onRatingSelected?(option)
        }
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        RateButton()
    }
}
