//
//  Category.swift
//  swftUIPractice1
//
//  Created by a on 27.06.24.
//

import Foundation

enum Category: String, CaseIterable{ // 让其遵循String才有rawValue
    case all, music, podcasts, audiobooks
}
