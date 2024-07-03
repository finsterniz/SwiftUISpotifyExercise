//
//  BumbleCardView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI

struct BumbleCardView: View {
    var user = User.mock
    @State private var cardFrame: CGRect = .zero
    var onSuperlikePressed: (()->Void)? = nil
    var onXmarkPressed: (()->Void)? = nil
    var onCheckmarkPressed: (()->Void)? = nil
    var onSendAComplementPressed: (()->Void)? = nil
    var onHideAndReportPressed: (()->Void)? = nil
    
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(spacing: 0){
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding(.vertical, 15)
                    .padding(.horizontal, 24)
                
                myInterestSection
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
                .padding(.horizontal, 24)

                ForEach(User.mock.images, id: \.self){image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                
                HStack{
                    checkButton(systemName: "xmark", shape: Circle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .asButton {
                            onCheckmarkPressed?()
                        }
                    checkButton(systemName: "checkmark", shape: Circle())
                        .asButton {
                            onCheckmarkPressed?()
                        }
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                Text("Hide and Report")
                    .padding(.bottom, 100)
                    .asButton {
                        onHideAndReportPressed?()
                    }
                
            }
        }
        .background(Color.bumbleBackgroundYellow)
        .frame(height: 700)
        .scrollIndicators(.hidden)
        .cornerRadius(32)
        .overlay(
            superLikeButton
                .padding(24)
        )
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var superLikeButton : some View{
        Image(systemName: "hexagon.fill")
            .foregroundColor(.bumbleYellow)
            .font(.system(size: 63))
            .overlay(
                Image(systemName: "star.fill")
                    .foregroundColor(.bumbleBlack)
                    .font(.system(size: 30))
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .asButton {
                onSuperlikePressed?()
            }
    }
    
    private func checkButton(systemName: String, shape: some Shape) -> some View {
        return Image(systemName: systemName)
            .font(.system(size: 30))
            .fontWeight(.semibold)
            .padding(15)
            .background(Color.bumbleYellow)
            .clipShape(shape)
    }
    
    private var locationSection: some View{
        VStack{
            HStack{
                Image(systemName: "mappin.and.ellipse.circle.fill")
                
                Text("\(user.firstName)'s Location")
                    .foregroundColor(Color.bumbleGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(user.distance) miles away")
                .fontWeight(.semibold)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            InterestPillView(
                iconName: nil,
                emoji: "🇺🇸",
                text: "Lives in New York, NY"
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(24)
    }
    
    private var myInterestSection : some View{
        VStack(alignment: .leading, spacing: 12){
            
            VStack(alignment: .leading, spacing: 8){
                Text("My basics")
                InterestPillGridView(interest: User.mock.basics)
            }
            
            VStack(alignment: .leading, spacing: 8){
                Text("My interest")
                InterestPillGridView(interest: User.mock.interests)
            }
        }
    }
    
    private var aboutMeSection : some View{
        VStack(alignment: .leading, spacing: 10){
            sectionTitle(title: "About Me")
         
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack{
                BumbleHeartIcon()
                    
                Text("Send me a complement")
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .asButton {
                onSendAComplementPressed?()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func sectionTitle(title: String) -> some View{
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    private var headerCell: some View{
        ZStack(alignment: .bottomLeading){
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment: .leading, spacing: 8){
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4){
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                
                HStack(spacing: 4){
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                
                BumbleHeartIcon()
                    .asButton(.opacity) {
                        
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.clear,
                            Color.black.opacity(
                                0.7
                            ),
                            Color.black.opacity(
                                0.7
                            )
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
    }
}

#Preview {
    ZStack{
        Color.white.ignoresSafeArea()
        BumbleCardView()
            .padding()
    }
}
