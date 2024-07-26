//
//  FilteredCategoriesView.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/26/24.
//

import SwiftUI

struct FilteredCategoriesView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        CategoriesView(query: searchText)
            .searchable(text: $searchText)
    }
}

#Preview {
    FilteredCategoriesView()
}

#Preview("Sample") {
    FilteredCategoriesView()
        .modelContainer(SampleData.shared.modelContainer)
}
