import UIKit
import Gwent_API

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let allCards = navigationController.viewControllers.first as! AllCardsViewController
        
        var loadededCards: [GwentAPI.Response.CardLink] = []
        var nextURL: URL?
        var loadMoreCards: Command? = nil
        
        let api = GwentAPI()
        loadMoreCards = Command {
            func handle(cards: GwentAPI.Response.Cards) -> AllCardsViewController.Props {
                loadededCards.append(contentsOf: cards.results)
                nextURL = cards.next
                if nextURL == nil { loadMoreCards = nil }
                
                let names = loadededCards.map { $0.name }
            
                return AllCardsViewController.Props(
                    cards: names,
                    lastCardDisplayed: loadMoreCards)
            }
            
            api.getCards(url: nextURL)
                .dispatch(on: .main)
                .map(handle(cards:))
                .onSuccess { allCards.props = $0 }
                .onError { error in
                    let alert = UIAlertController(
                        title: "Cannot receive cards",
                        message: error.localizedDescription,
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ok :(", style: .cancel))
                    allCards.present(alert, animated: true)
            }
        }
        
        allCards.props = .init(
            cards: ["Loading..."],
            lastCardDisplayed: nil
        )
        
        loadMoreCards?.perform()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

