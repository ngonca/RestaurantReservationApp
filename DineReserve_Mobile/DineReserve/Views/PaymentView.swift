import SwiftUI

struct PaymentView: View {
    @State private var cardOwner = ""
    @State private var cardNumber = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var showPaymentGuide = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var restaurantId: Int

    var body: some View {
        VStack {
            Image("credit-card")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.top, 20)

            Form {
                Section(header: Text("Payment Details")) {
                    TextField("Card Owner", text: $cardOwner)
                    TextField("Card Number", text: $cardNumber)
                        .keyboardType(.numberPad)
                    TextField("Expiration Date (MM/YY)", text: $expirationDate)
                    TextField("CVV", text: $cvv)
                        .keyboardType(.numberPad)
                }

                Section {
                    Button(action: {
                        // Alanlar boş mu kontrolü
                        if cardOwner.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            cardNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            expirationDate.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                            cvv.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertTitle = "Eksik Bilgi"
                            alertMessage = "Lütfen tüm alanları doldurunuz."
                            showAlert = true
                            return
                        }

                        let paymentModel = PaymentRequestModel(
                            paymentMethod: 0,
                            reservationId: 5,
                            cardNumber: cardNumber,
                            expirationDate: expirationDate,
                            cardOwner: cardOwner,
                            paymentDate: "2025-05-17T13:45:30Z",
                            restaurantId: restaurantId,
                            cvv: cvv
                        )

                        NetworkManager.shared.request(endpoint: PaymentAPI.postPayment(model: paymentModel)) { (result: Result<String, APIError>) in
                            DispatchQueue.main.async {
                                alertTitle = "Ödeme Başarılı"
                                alertMessage = "Rezervasyonunuz başarıyla tamamlandı. Rezervasyonlarım kısmından kontrol edebilirsiniz."
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Pay Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }

            Button(action: {
                showPaymentGuide = true
            }) {
                Text("View Payment Guide")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .underline()
                    .padding()
            }
        }
        .navigationTitle("Payment")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Tamam"))
            )
        }
        .sheet(isPresented: $showPaymentGuide) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Payment Guide")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text("1. Enter your card details accurately.")
                Text("2. Ensure the expiration date is in MM/YY format.")
                Text("3. The CVV is the 3-digit code on the back of your card.")
                Text("4. Tap 'Pay Now' to complete your payment.")

                Spacer()

                Button(action: {
                    showPaymentGuide = false
                }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
}
