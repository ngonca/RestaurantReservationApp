import SwiftUI

// Splash Screen View
struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                MainView()
            } else {
                Color.white.ignoresSafeArea()
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isActive = true
                }
            }
        }
    }
}

struct MainView: View {
    @State private var selectedTab = 0
    @State private var isLoggedOut = false

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Log Out") {
                                UIApplication.shared.popToRoot()
                            }
                        }
                    }
                    .background(
                        NavigationLink(destination: LoginView(), isActive: $isLoggedOut) {
                            EmptyView()
                        }
                        .hidden()
                    )
                    .tag(0)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                SavedView()
                    .tag(1)
                    .tabItem {
                        Label("Saved", systemImage: "bookmark.fill")
                    }

                ReservationsView()
                    .tag(2)
                    .tabItem {
                        Label("Reservations", systemImage: "calendar")
                    }

                ProfileView()
                    .tag(3)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Previews
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

