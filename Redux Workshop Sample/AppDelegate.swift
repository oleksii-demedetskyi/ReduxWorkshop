import UIKit
import Gwent_API

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let allCards = navigationController.viewControllers.first as! AllCardsViewController
        
        allCards.props = .init(
            cards: ["Loading...."]
        )
        
//        let api = GwentAPI()
//        let cardsFuture = api.getCards()
//            .map { response in response.results.map { $0.name } }
//            .dispatch(on: .main)
        
        let cardsFuture = Future(value: Result.value(["Test 1", "Test 2", "Test 3"]))
            .delay(on: .main, to: .now() + .seconds(2))
        
        cardsFuture
            .map { cardNames in AllCardsViewController.Props(cards: cardNames) }
            
            .onSuccess { allCards.props = $0 }
            .onError { error in
                let alert = UIAlertController(
                    title: "Cannot receive cards",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok :(", style: .cancel))
                allCards.present(alert, animated: true)
                
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

