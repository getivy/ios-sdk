import UIKit

extension PresentationUIHandler {
    func buildBankView() throws -> BankViewController {
        let storyboard = UIStoryboard(name: "BankView", bundle: Bundle(for: PresentationUIHandler.self))

        guard let viewController = storyboard.instantiateViewController(withIdentifier: "BankViewController") as? BankViewController else {
            throw GetivySDKError.couldNotLoadViewFromStoryboard
        }

        viewController.banksService = BanksApiService(
            context: NonPersistentApiContext(environment: config.environment),
            session: URLSession.shared,
            parser: BanksResponseParser()
        )
        viewController.router = self

        return viewController
    }

    func buildWebView(bankId: String) throws -> WebViewController {
        let storyboard = UIStoryboard(name: "WebView", bundle: Bundle(for: PresentationUIHandler.self))

        guard let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else {
            throw GetivySDKError.couldNotLoadViewFromStoryboard
        }

        viewController.bankId = bankId
        viewController.router = self

        return viewController
    }

    func buildLanguages() throws -> LanguagesViewController {
        let storyboard = UIStoryboard(name: "LanguagesView", bundle: Bundle(for: PresentationUIHandler.self))

        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as? LanguagesViewController else {
            throw GetivySDKError.couldNotLoadViewFromStoryboard
        }
        
        viewController.router = self

        return viewController
    }
}
