import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var city: String = ""
    @State private var phoneNumber: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("Create Account")
                        .font(.largeTitle.bold())
                        .foregroundColor(.blue)
                        .padding(.top, 40)

                    Group {
                        InputField(title: "First Name", text: $firstName)
                        InputField(title: "Last Name", text: $lastName)
                        InputField(title: "City", text: $city)
                        InputField(title: "Phone Number", text: $phoneNumber, keyboardType: .phonePad)
                        InputField(title: "Email", text: $email, keyboardType: .emailAddress)
                        SecureInputField(title: "Password", text: $password)
                        SecureInputField(title: "Confirm Password", text: $confirmPassword)
                    }

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }

                    Button(action: register) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding()
            }

            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }

            // ✅ fullScreenCover: Giriş yaptıktan sonra geri dönüş yok
            .fullScreenCover(isPresented: $isLoggedIn) {
                MainView()
            }
        }
    }

    private func register() {
        // Giriş doğrulama
        guard !firstName.isEmpty else { errorMessage = "First name is required"; return }
        guard !lastName.isEmpty else { errorMessage = "Last name is required"; return }
        guard !city.isEmpty else { errorMessage = "City is required"; return }
        guard !phoneNumber.isEmpty else { errorMessage = "Phone number is required"; return }
        guard !email.isEmpty else { errorMessage = "Email is required"; return }
        guard !password.isEmpty else { errorMessage = "Password is required"; return }
        guard password == confirmPassword else { errorMessage = "Passwords do not match"; return }

        errorMessage = ""

        NetworkManager.shared.request(
            endpoint: RegisterAPI.registerCustomer(
                RegisterRequest(
                    firstName: firstName,
                    lastName: lastName,
                    city: city,
                    email: email,
                    phoneNumber: phoneNumber,
                    password: password,
                    confirmPassword: confirmPassword
                )
            )
        ) { (result: Result<RegisterResponse, APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    isLoggedIn = true 
                case .failure(let error):
                    alertMessage = "Registration failed!\nError: \(error.localizedDescription)"
                    showAlert = true
                }
            }
        }
    }
}
