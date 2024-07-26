//
//  SortOrder.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/26/24.
//

import Foundation

enum SortOrder: String, CaseIterable, Identifiable {
    case name
    case servingLowToHigh
    case servingHighToLow
    case timeShortToLong
    case timeLongToShort
    
    var id: String { rawValue }
    
    var sortDescriptors: [SortDescriptor<Recipe>] {
        switch self {
        case .name:
            return [SortDescriptor(\Recipe.name)]
        case .servingLowToHigh:
            return [SortDescriptor(\Recipe.serving, order: .forward)]
        case .servingHighToLow:
            return [SortDescriptor(\Recipe.serving, order: .reverse)]
        case .timeShortToLong:
            return [SortDescriptor(\Recipe.time, order: .forward)]
        case .timeLongToShort:
            return [SortDescriptor(\Recipe.time, order: .reverse)]
        }
    }
}
