import Foundation
import SwiftUI

// MARK: - ReservationItemView
struct ReservationItemView: View {
    //@EnvironmentObject var session: UserSession

    let reservation: ReservationResponseModel
    let onCancel: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(String(describing: reservation.restaurantId))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text("Date: \(reservation.reservationDate.toFormattedDate())")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: onCancel) {
                Text("Cancel Reservation")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .foregroundColor(.red)
                    .cornerRadius(8)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.vertical, 4)
    }
}

// MARK: - ReservationsView
struct ReservationsView: View {
    @EnvironmentObject var session: UserSession
    @State private var reservations: [ReservationResponseModel] = []
    @State private var showAlert = false
    @State private var selectedIndex: Int? = nil
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading Reservations...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List {
                        ForEach(reservations, id: \.id) { reservation in
                            ReservationItemView(reservation: reservation) {
                                if let index = reservations.firstIndex(where: { $0.id == reservation.id }) {
                                    selectedIndex = index
                                    showAlert = true
                                }
                            }
                        }
                    }
                    .navigationTitle("Reservations")
                    .alert("Are you sure you want to cancel?", isPresented: $showAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Yes, Cancel", role: .destructive) {
                            if let index = selectedIndex {
                                let reservationId = reservations[index].id
                                
                                // API'den silme isteği gönder
                                NetworkManager.shared.request(endpoint: ReservationAPI.cancelReservation(reservationId)) { (result: Result<EmptyResponse, APIError>) in
                                    switch result {
                                    case .success:
                                        // Başarıyla silindiyse, arayüzden de sil
                                        DispatchQueue.main.async {
                                            reservations.remove(at: index)
                                        }
                                    case .failure(let error):
                                        print("Failed to cancel reservation: \(error)")
                                    }
                                }
                            }
                        }
                    }

                }
            }
            .onAppear {
                
                guard let customerId = session.userId else {
                       print("User not logged in.")
                       return
                   }
                
                NetworkManager.shared.request(endpoint: ReservationAPI.reservationHistory(customerId:customerId )) { (result: Result<[ReservationResponseModel], APIError>) in
                    switch result {
                    case .success(let reservationsData):
                        self.reservations = reservationsData
                        self.isLoading = false
                    case .failure(let error):
                        print("Error fetching reservations: \(error)")
                        self.isLoading = false
                    }
                }
            }
        }
    }
}

