import SwiftUI


// MARK: - CategoryCard Component
struct CategoryCard: View {
    var cuisine: String
    var categoryId: Int // <-- Yeni: API için kategori ID
    @State private var showRestaurants = false
    @State private var restaurants: [RestaurantResponseModel] = [] // <-- API'den gelen liste
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Button(action: {
            }) {
                ZStack {
                    Image(cuisine.lowercased())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 90)
                        .cornerRadius(15)
                        .clipped()
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .cornerRadius(15)

                    Text(cuisine)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 3)
                }
                .frame(width: 130, height: 100)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
            }
            .disabled(isLoading)
            .sheet(isPresented: $showRestaurants) {
                
            }
        }
    }


}
