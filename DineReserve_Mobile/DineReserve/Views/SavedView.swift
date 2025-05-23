import SwiftUI

struct SavedView: View {
    @EnvironmentObject var session: UserSession // ← Kullanıcı bilgisi
    @State private var favorites: [FavoritesResponseModel] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if favorites.isEmpty {
                    VStack {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                        Text("Your saved restaurants will appear here.")
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(favorites, id: \.id) { restaurant in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(restaurant.name)
                                        .font(.headline)
                                    Text("\(restaurant.city), \(restaurant.street)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button(action: {
                                    deleteFavorite(restaurantId: restaurant.id)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Saved")
        }
        .onAppear {
            fetchFavorites()
        }
    }

    private func fetchFavorites() {
        guard let customerId = session.userId else {
            errorMessage = "User not logged in."
            return
        }

        isLoading = true
        errorMessage = nil

        NetworkManager.shared.request(
            endpoint: FavoritesAPI.fetchFavorites(customerId: customerId)
        ) { (result: Result<[FavoritesResponseModel], APIError>) in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let data):
                    favorites = data
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func deleteFavorite(restaurantId: Int) {
        guard let customerId = session.userId else {
            errorMessage = "User not logged in."
            return
        }

        isLoading = true
        NetworkManager.shared.request(
            endpoint: FavoritesAPI.deleteFavorite(model: FavoriteRemoveRequestModel(customerId: customerId, restaurantId: restaurantId))
        ) { (result: Result<String, APIError>) in
            DispatchQueue.main.async {
                isLoading = false
                favorites.removeAll { $0.id == restaurantId }
            }
        }
    }
}
