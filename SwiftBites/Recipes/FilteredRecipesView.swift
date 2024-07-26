//
//  FilteredRecipesView.swift
//  SwiftBites
//
//  Created by Madhu Babu Adiki on 7/26/24.
//

import SwiftUI

struct FilteredRecipesView: View {
    
    @State private var query = ""
    
    var body: some View {
        RecipesView(query: query)
            .searchable(text: $query)
    }
}

#Preview {
    FilteredRecipesView()
}

#Preview("Sample") {
    FilteredRecipesView()
        .modelContainer(SampleData.shared.modelContainer)
}
