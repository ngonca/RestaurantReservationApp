import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search for restaurants...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Button(action: {
                // Optional: Add search action
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        // Declare a state variable for preview
        @State var searchText = ""

        return SearchBar(searchText: $searchText)
    }
}
