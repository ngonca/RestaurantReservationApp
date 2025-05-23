import SwiftUI

struct HomeView: View {
    @State private var selectedLocation: String = ""
    @State private var isProfileActive: Bool = false
    @State private var restaurants: [RestaurantResponseModel] = []

    @State private var navigateToItalian = false
    @State private var navigateToAsian = false
    @State private var navigateToTurkish = false
    @State private var navigateToMexican = false

    let locations = ["istan", "Istanbul","Antalya"]
    let categories = ["Italian", "Asian", "Turkish", "Mexican"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Location Dropdown
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Select Location")
                                .font(.title2)
                                .fontWeight(.semibold)

                            Picker("Location", selection: $selectedLocation) {
                                Text("All Locations").tag("")
                                ForEach(locations, id: \.self) { location in
                                    Text(location)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                        .padding(.leading)

                        Spacer()
                    }
                    .padding(.top, 20)

                    // Popular Restaurants
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Popular Restaurants")
                            .font(.title2)
                            .fontWeight(.semibold)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(restaurants, id: \.id) { restaurant in
                                    RestaurantCard(restaurant: restaurant)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Category Buttons
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.semibold)

                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                switch category {
                                case "Italian":
                                    navigateToItalian = true
                                case "Asian":
                                    navigateToAsian = true
                                case "Turkish":
                                    navigateToTurkish = true
                                case "Mexican":
                                    navigateToMexican = true
                                default:
                                    break
                                }
                            }) {
                                ZStack {
                                    Image(category)
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .cornerRadius(10)

                                    Color.black.opacity(0.3)
                                        .cornerRadius(10)

                                    Text(category)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .buttonStyle(PlainButtonStyle()) // önemli!
                      }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("DineReserve")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 30)
                }
            }
            .navigationDestination(isPresented: $isProfileActive) {
                ProfileView()
            }
            .navigationDestination(isPresented: $navigateToItalian) {
                ItalianRestaurantsView()
            }
            .navigationDestination(isPresented: $navigateToAsian) {
                AsianRestaurantsView()
            }
            .navigationDestination(isPresented: $navigateToTurkish) {
                TurkishRestaurantsView()
            }
            .navigationDestination(isPresented: $navigateToMexican) {
                MexicanRestaurantsView()
            }
            .onChange(of: selectedLocation) { _ in
                fetchRestaurants()
            }
            .onAppear {
                fetchRestaurants()
            }
        }
    }

    func fetchRestaurants() {
        if selectedLocation.isEmpty {
            NetworkManager.shared.request(endpoint: RestaurantAPI.fetchRestaurants) { (result: Result<[RestaurantResponseModel], APIError>) in
                switch result {
                case .success(let data):
                    restaurants = data
                case .failure(let error):
                    print("Tüm restoranlar alınamadı: \(error)")
                }
            }
        } else {
            NetworkManager.shared.request(endpoint: LocationAPI.fetchRestaurantsByCity(selectedLocation)) { (result: Result<[RestaurantResponseModel], APIError>) in
                switch result {
                case .success(let restaurant):
                    restaurants = restaurant
                case .failure(let error):
                    print("Şehre özel restoranlar alınamadı: \(error)")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
