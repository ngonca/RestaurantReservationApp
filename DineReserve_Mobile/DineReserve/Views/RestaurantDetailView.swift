import SwiftUI
import Foundation

struct RestaurantDetailView: View {
    @EnvironmentObject var session: UserSession

    @State private var isFavorite: Bool = false
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var menuItems: [MenuResponseModel] = []
    
    @State var id: Int

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Restaurant Image + Favorite Button
                ZStack(alignment: .topTrailing) {
                    Image("restaurant-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    Button(action: {
                        isFavorite.toggle()

                        guard let customerId = session.userId else {
                            print("Kullanıcı oturumu bulunamadı.")
                            return
                        }

                        if isFavorite {
                            let model = FavoriteAddRequestModel(customerId: customerId, restaurantId: id)
                            NetworkManager.shared.request(endpoint: FavoritesAPI.addFavorite(model: model)) { (result: Result<String, APIError>) in
                                switch result {
                                case .success:
                                    print("Favori başarıyla eklendi.")
                                case .failure(let error):
                                    print("Favori eklenirken hata oluştu: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            let model = FavoriteRemoveRequestModel(customerId: customerId, restaurantId: id)
                            NetworkManager.shared.request(endpoint: FavoritesAPI.deleteFavorite(model: model)) { (result: Result<String, APIError>) in
                                switch result {
                                case .success:
                                    print("Favori başarıyla silindi.")
                                case .failure(let error):
                                    print("Favori silinirken hata oluştu: \(error.localizedDescription)")
                                }
                            }
                        }
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(isFavorite ? .red : .white)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding()
                }

                // Restaurant Info (DÜZELTİLDİ)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Restaurant Information")
                        .font(.headline)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Restaurant Name: \(name)")
                                .font(.body)
                        }
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Phone Number: \(phoneNumber)")
                                .font(.body)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                }
                .padding(.horizontal)

                // Menu Items
                VStack(alignment: .leading, spacing: 10) {
                    Text("Menu")
                        .font(.title2)
                        .fontWeight(.semibold)

                    if menuItems.isEmpty {
                        Text("No menu items available.")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(menuItems) { item in
                            HStack(alignment: .top) {
                                Image(systemName: "fork.knife")
                                    .foregroundColor(.blue)
                                    .padding(.top, 4)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(item.name) - ₺\(String(format: "%.2f", item.price))")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text(item.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Reservation Button
                NavigationLink(destination: MakeReservationView(restaurantid: id)) {
                    Text("Make a Reservation")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle("Restaurant Details")
        .onAppear {
            // Menü çekme
            NetworkManager.shared.request(endpoint: menuAPI.fetchRestaurantMenuItems(id)) { (result: Result<[MenuResponseModel], APIError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let items):
                        self.menuItems = items
                    case .failure(let error):
                        print("Menü yüklenemedi: \(error.localizedDescription)")
                    }
                }
            }

            // Restoran bilgisi çekme
            NetworkManager.shared.request(endpoint: RestaurantAPI.fetchRestaurant(id)) { (result: Result<RestaurantResponseModel, APIError>) in
                switch result {
                case .success(let restaurant):
                    name = restaurant.name ?? ""
                    phoneNumber = restaurant.phoneNumber ?? ""
                case .failure(let error):
                    print("Restoran bilgisi alınamadı: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(id: 0)
            .environmentObject(UserSession())
    }
}
