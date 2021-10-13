import SwiftUI
import Defaults
import ARKit

struct MainTabView: View {
    @EnvironmentObject var env : Env
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        TabView {
            NavigationView {
                SummaryTabView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Summary", systemImage: "square.stack.3d.up")
            }
            
            if ARWorldTrackingConfiguration.isSupported {
                NavigationView {
                    CameraTabView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("Camera", systemImage: "arkit")
                }
            }
            
            NavigationView {
                SettingsTabView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .sheet(item: $env.authState) {
            
        } content: { state in
            switch state {
            case .login:
                LoginView()
            case .resetPassword(let info):
                ResetPasswordView()
            case .confirmSignInWithNewPassword(let info):
                NewPasswordView()
            default:
                ZStack {}
            }
        }

    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}