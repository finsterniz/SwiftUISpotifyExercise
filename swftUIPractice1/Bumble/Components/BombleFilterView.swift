//
//  BombleHomeview.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI
import SwiftfulUI

struct BombleFilterView: View {
    var options: [String] = ["Everyone", "Trending"]
    @Binding var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32){
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8){
                    Text(option)
                        .fontWeight(.medium)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
//                        .background(.blue)
                    
                    if selection == option{
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                        
                        
                }
                .padding(.top, 8)
                .background(.black.opacity(0.001))
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .asButton {
                    selection = option
                }
            }
        }
        .animation(.smooth(duration: 0.3), value: selection)
    }
}

fileprivate struct BumbleFilterPreview: View{
    @State var selection: String = "option3"
    var options = ["option1", "option2", "option3"]
    var body: some View{
        BombleFilterView(options: options, selection: $selection)
    }
}

#Preview {
    BumbleFilterPreview()
}
