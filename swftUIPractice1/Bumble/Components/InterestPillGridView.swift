//
//  InterestPillGridView.swift
//  swftUIPractice1
//
//  Created by a on 02.07.24.
//

import SwiftUI
import SwiftfulUI

struct UserInterest : Codable, Identifiable, Hashable{
    var id = UUID()
    var iconName : String? = nil
    var emoji: String? = nil
    var text: String
}

struct InterestPillGridView: View {
    var interest: [UserInterest] = User.mock.basics
    var body: some View {
        ZStack{
            NonLazyVGrid(
                columns: 2,
                alignment: .leading,
                spacing: 8,
                items: interest) { interest in
                    InterestPillView(
                        iconName: interest?.iconName,
                        emoji: interest?.emoji,
                        text: interest?.text ?? ""
                    )
                }
        }
    }
}

#Preview {
    VStack{
        InterestPillGridView(interest: User.mock.basics)
        InterestPillGridView(interest: User.mock.interests)
    }
}
