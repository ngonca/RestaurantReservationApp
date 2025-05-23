import SwiftUI

struct RestaurantCard: View {
    let restaurant: RestaurantResponseModel

    var body: some View {
        NavigationLink(destination: RestaurantDetailView(id: restaurant.id ?? 0)) {
            VStack(alignment: .leading) {
                Image("restaurant-placeholder") // Gerçek görsel kullanacaksan burayı değiştir
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .cornerRadius(10)
                    .clipped()

                Text(restaurant.name ?? "Unknown")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.top, 5)

                Text(getCuisineName(from: restaurant.restaurantCategory ?? -1))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(width: 150)
        }
    }

    // Kategori ID'ye göre isim döndür
    func getCuisineName(from categoryId: Int) -> String {
        switch categoryId {
        case 0: return "Italian"
        case 1: return "Asian"
        case 2: return "Turkish"
        case 3: return "Mexican"
        default: return "Unknown"
        }
    }
}
