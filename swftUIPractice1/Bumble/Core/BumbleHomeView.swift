//
//  BumbleHomeView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {
    @State var filters = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers : [User] = []
    @State private var selectedIndex: Int = 1
    @State private var cardOffsets: [Int : Bool] = [:] // UserID: (Direction is Right == TRUE)
    @State private var currentSwipeOffset: CGFloat = 0
    
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
                
                ZStack{
                    if !allUsers.isEmpty{
                        ZStack{
                            ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                                let isPrevious = (selectedIndex - 1) == index
                                let isCurrent = index == selectedIndex
                                let isNext = (selectedIndex + 1) == index
                                if isCurrent || isPrevious || isNext{
                                    let offsetValue = cardOffsets[user.id]
                                    
                                    userProfileCell(user: user, index: index)
                                        .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                                        .zIndex(Double(allUsers.count - index)) // The frontmost is represented by the larger index value.
                                }
                            }
                        }
                    }else{
                        ProgressView()
                    }
                    
                    
                    
                    overlaySwipingIndicators
                    .animation(.smooth(duration: 0.3), value: currentSwipeOffset)
                    .zIndex(9999)
                }
                .padding(4)
                .animation(.smooth(duration: 0.3), value: cardOffsets)
            }
            .task {
                await getData()
            }
        }
        .padding(8)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var overlaySwipingIndicators: some View{
        ZStack{
            Circle()
                .opacity(0.4)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) // if offset bigger than 100, then scale from 1.0 to 1.5
                .offset(x: min(-currentSwipeOffset, 120)) // min make it not move to the center of the screen
                .offset(x: -100) // hide it off the screen
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .opacity(0.4)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0) // if offset bigger than 100, then scale from 1.0 to 1.5
                .offset(x: max(-currentSwipeOffset, -120)) // min make it not move to the center of the screen
                .offset(x: 100) // hide it off the screen
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private func userProfileCell(user: User, index: Int)->some View{
        BumbleCardView(
            user: user,
            onSuperlikePressed: nil,
            onXmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            onSendAComplementPressed: nil,
            onHideAndReportPressed: nil
        )
            .withDragGesture(
                .horizontal,
                minimumDistance: 10, //only if drag more than 10 pixel, the drag gesture is triggered
                resets: true, // if reset the placement
                rotationMultiplier: 1.05, // add some rotation effects
//                                            scaleMultiplier: 0.8, // scale the content if dragged
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50{
                        userDidSelect(index: selectedIndex, isLike: false)
                    }else if dragOffset.width > 50{
                        userDidSelect(index: selectedIndex, isLike: true)
                    }
                }
            )
    }
    
    func userDidSelect(index: Int, isLike: Bool){
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        selectedIndex += 1
    }
    
    private func getData() async {
        do{
            guard allUsers.isEmpty else{
                return
            }
            
            allUsers = try await DatabaseHelper().getUsers()
        }catch{
            print("Error getting Users \(error)")
        }
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
