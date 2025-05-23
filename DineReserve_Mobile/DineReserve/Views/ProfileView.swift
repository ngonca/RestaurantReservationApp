import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: UserSession

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var city = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill")

    func saveProfileChanges() {
        guard let userId = session.userId else { return }

        let updatedProfile = CustomerRequestModel(
            id: userId,
            firstName: firstName,
            lastName: lastName,
            city: city,
            email: email,
            phoneNumber: phoneNumber,
            profilePictureUrl: nil
        )

        NetworkManager.shared.request(
            endpoint: CustomerAPI.updateCustomerProfile(id: userId, profile: updatedProfile)
        ) { (result: Result<CustomerResponseModel, APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedCustomer):
                    // Session güncellemesi (gerekirse UserSession'daki update() fonksiyonu genişletilebilir)
                    print("Profile updated successfully: \(updatedCustomer)")
                case .failure(let error):
                    print("Error updating profile: \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchUserProfile() {
        guard let userId = session.userId else { return }

        NetworkManager.shared.request(endpoint: CustomerAPI.fetchCustomers) { (result: Result<[CustomerResponseModel], APIError>) in
            switch result {
            case .success(let customers):
                if let customer = customers.first(where: { $0.id == userId }) {
                    DispatchQueue.main.async {
                        firstName = customer.firstName
                        lastName = customer.lastName
                        city = customer.city
                        email = customer.email
                        phoneNumber = customer.phoneNumber
                    }
                }
            case .failure(let error):
                print("Fetch error: \(error)")
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                // Profile Image Section
                VStack {
                    profileImage?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                        .shadow(radius: 5)
                        .onTapGesture {
                            // TODO: Image picker implementation
                        }

                    Text("\(firstName.isEmpty ? "First" : firstName) \(lastName.isEmpty ? "Last" : lastName)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)

                // Personal Information Section
                Section(header: Text("Personal Information").font(.headline).foregroundColor(.gray)) {
                    VStack(alignment: .leading, spacing: 8) {
                        ProfileRow(icon: "person.fill", title: "First Name", text: $firstName)
                        ProfileRow(icon: "person.fill", title: "Last Name", text: $lastName)
                        ProfileRow(icon: "building.2.fill", title: "City", text: $city)
                        ProfileRow(icon: "envelope.fill", title: "Email", text: $email, keyboardType: .emailAddress)
                        ProfileRow(icon: "phone.fill", title: "Phone", text: $phoneNumber, keyboardType: .phonePad)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                }

                // Save Button Section
                Section {
                    Button(action: saveProfileChanges) {
                        HStack {
                            Spacer()
                            Text("Save Changes")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Profile")
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                fetchUserProfile()
            }
        }
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)

            TextField(title, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(title == "Email" ? .none : .words)
                .disableAutocorrection(true)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.vertical, 4)
    }
}
