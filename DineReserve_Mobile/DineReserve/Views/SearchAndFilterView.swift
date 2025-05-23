//
//  SearchAndFilterView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 5.03.2025.
//

import Foundation
import SwiftUI

// MARK: - Search and Filter Page
struct SearchAndFilterView: View {
    @State private var searchText = ""
    @State private var selectedCuisine = ""
    @State private var priceRange: ClosedRange<Double> = 0...100
    @State private var location = ""
    
    var body: some View {
        Form {
            Section(header: Text("Search")) {
                TextField("Search for restaurants...", text: $searchText)
            }
            
            Section(header: Text("Filters")) {
                Picker("Cuisine", selection: $selectedCuisine) {
                    ForEach(["Italian", "Asian", "Mediterranean", "Mexican", "Indian"], id: \.self) {
                        Text($0)
                    }
                }
                
                
                TextField("Location", text: $location)
            }
            
            Section {
                Button("Apply Filters") {
                    // Handle filter application
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        VStack(alignment: .leading) {
            Text("Price Range: $\(Int(priceRange.lowerBound)) - $\(Int(priceRange.upperBound))")
            //Slider(value: $priceRange, in: 0...100, step: 10.0)
        }
        
        .navigationTitle("Search & Filter")
    }
}
// MARK: - Preview
struct SearchAndFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAndFilterView()
    }
}
