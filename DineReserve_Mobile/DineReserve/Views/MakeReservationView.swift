import Foundation
import SwiftUI

// MARK: - Make Reservation Page
struct MakeReservationView: View {
    @EnvironmentObject var session: UserSession  // ← Kullanıcı bilgisi için

    @State private var selectedDate = Date()
    @State private var partySize = 1
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var isPaymentViewActive = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State var restaurantid: Int
    
    
    var body: some View {
        Form {
            Section(header: Text("Reservation Details")) {
                DatePicker("Date & Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                Stepper("Party Size: \(partySize)", value: $partySize, in: 1...20)
            }
            
            Section(header: Text("Contact Information")) {
                TextField("Name", text: $name)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
            }
            
            Section {
                Button("Confirm Reservation") {
                    guard let customerId = session.userId else {
                        alertMessage = "Giriş yapan kullanıcı bulunamadı."
                        showAlert = true
                        return
                    }

                    if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        alertMessage = "Lütfen isim ve telefon numarası alanlarını doldurunuz."
                        showAlert = true
                        return
                    }

                    let model = ReservationRequestModel(
                        customerId: customerId,
                        restaurantId: restaurantid,
                        reservationDate: selectedDate.toISO8601String(),
                        timeSlot: "", // İsteğe bağlı olarak eklenebilir
                        numberOfPeople: partySize,
                        availabilityId: 1 // Geliştirilebilir
                    )

                    NetworkManager.shared.request(endpoint: ReservationAPI.sendReservation(model: model)) { (result: Result<RegisterResponse, APIError>) in
                        DispatchQueue.main.async {
                            self.isPaymentViewActive = true
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Make Reservation")
        .background(
            NavigationLink(
                destination: PaymentView(restaurantId: restaurantid),
                isActive: $isPaymentViewActive,
                label: { EmptyView() }
            )
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Uyarı"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
    }
}

// MARK: - Preview
struct MakeReservationView_Previews: PreviewProvider {
    static var previews: some View {
        MakeReservationView(restaurantid: 0)
            .environmentObject(UserSession()) // Preview için environmentObject
    }
}
