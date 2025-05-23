import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false

    @EnvironmentObject var session: UserSession

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("DineReserve")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 40)

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }

                    Button(action: login) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account? Register")
                            .foregroundColor(.blue) // 🔵 Renk değiştirildi
                            .underline()
                            .padding()
                    }
                }
                .padding()
            }
            .fullScreenCover(isPresented: $isLoggedIn) {
                MainView()
                    .environmentObject(session)
            }
            .navigationTitle("Login")
        }
    }

    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun."
            return
        }

        let request = LoginRequest(email: email, password: password)

        NetworkManager.shared.request(endpoint: LoginAPI.loginCustomer(request)) { (result: Result<LoginResponseModel, APIError>) in
            Task { @MainActor in
                switch result {
                case .success(let response):
                    session.update(from: response)
                    isLoggedIn = true 
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
