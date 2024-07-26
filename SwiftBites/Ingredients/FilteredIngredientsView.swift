//
//  FilteredIngredientsView.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/25/24.
//

import SwiftUI

struct FilteredIngredientsView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        IngredientsView(titleFilter: searchText)
            .searchable(text: $searchText)
    }
}

#Preview {
    FilteredIngredientsView()
}

#Preview("Sample") {
    FilteredIngredientsView()
        .modelContainer(SampleData.shared.modelContainer)
}
