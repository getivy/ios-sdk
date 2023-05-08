import UIKit

extension PresentationUIHandler {
    func buildBankView() -> BankViewController {
        let storyboard = UIStoryboard(name: "BankView", bundle: Bundle(for: PresentationUIHandler.self))

        let viewController = storyboard.instantiateViewController(withIdentifier: "BankViewController") as! BankViewController

        viewController.router = self

        return viewController
    }

    func buildWebView() -> WebViewController {
        return WebViewController()
    }

    func buildLanguages() -> LanguagesViewController {
        let storyboard = UIStoryboard(name: "LanguagesView", bundle: Bundle(for: PresentationUIHandler.self))

        let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as! LanguagesViewController

        return viewController
    }
}
