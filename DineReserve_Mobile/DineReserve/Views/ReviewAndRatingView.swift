//
//  ReviewAndRatingView.swift
//  DineReserve
//
//  Created by Nazli Gonca on 5.03.2025.
//

import Foundation
import SwiftUI

// MARK: - Review and Rating Page
struct ReviewAndRatingView: View {
    @State private var rating = 0
    @State private var comment = ""
    
    var body: some View {
        Form {
            Section(header: Text("Rate the Restaurant")) {
                Picker("Rating", selection: $rating) {
                    ForEach(1..<6) { star in
                        Text("\(star) Star\(star > 1 ? "s" : "")")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Leave a Comment")) {
                TextEditor(text: $comment)
                    .frame(height: 100)
            }
            
            Section {
                Button("Submit Review") {
                    // Handle review submission
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Review & Rating")
    }
}

// MARK: - Preview
struct ReviewAndRatingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewAndRatingView()
    }
}
