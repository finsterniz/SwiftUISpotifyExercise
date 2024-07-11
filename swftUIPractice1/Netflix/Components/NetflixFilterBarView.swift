//
//  NetflixFilterBarView.swift
//  swftUIPractice1
//
//  Created by a on 06.07.24.
//

import SwiftUI

struct FilterModel: Hashable, Equatable{
    let title: String
    var isDropdown: Bool = false
    var isSelected: Bool = false
    
    init(title: String, isDropped: Bool, isSelected: Bool) {
        self.title = title
        self.isDropdown = isDropped
        self.isSelected = isSelected
    }
    
    static var mockData: [FilterModel]{
        return [
            FilterModel(title: "TV Shows", isDropped: false, isSelected: false),
            FilterModel(title: "Movies", isDropped: false, isSelected: false),
            FilterModel(title: "Categories", isDropped: true, isSelected: false),
        ]
    }
}

struct NetflixFilterBarView: View {
    
    var onXmarkPressed: (()->Void)? = nil
    var onFilterPressed: ((FilterModel)->Void)? = nil
    
    @Binding var selectedFilter: FilterModel?
    @Binding var filters: [FilterModel]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                if selectedFilter != nil{
                    Image(systemName: "xmark")
                        .padding(8)
                        .padding(.vertical, 4)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .padding(.leading, 16)
                        .foregroundColor(.netflixLightGray)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onXmarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading,8)
                }
                
                ForEach(FilterModel.mockData, id: \.self.title) { filter in
                    if selectedFilter == nil || selectedFilter == filter{
                        NetflixFilterCell(title: filter.title, isDropdown: filter.isDropdown, isSelected: selectedFilter == filter)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                onFilterPressed?(filter)
                            }
                            .padding(.leading, ((selectedFilter == nil) && (filter == .mockData.first)) ? 8 : 0)
                    }
                }
            }
            .padding(.vertical, 3)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

fileprivate struct NetflixFilterBarViewPreview: View{
    
    @State private var filters = FilterModel.mockData
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View{
        NetflixFilterBarView(
            onXmarkPressed: {selectedFilter = nil},
            onFilterPressed: { newFilter in
                selectedFilter = newFilter
            },
            selectedFilter: $selectedFilter,
            filters: $filters
        )
    }
    
}

#Preview {
    ZStack{
        Color.spotifyBlack.ignoresSafeArea()
        
        NetflixFilterBarViewPreview()
    }
}
