import SwiftUI

@main
struct FootballApp: App {
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch() {
                FootballOnboardingView()
            } else {
                FootballTabBarView()
            }
        }
    }
    
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
        
        return false
    }
}
