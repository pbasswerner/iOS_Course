import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let connectLandingVC = ConnectLandingViewController()
        window?.rootViewController = UINavigationController(rootViewController: connectLandingVC)
        window?.makeKeyAndVisible()
        return true
    }
}
