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

    func buildWebView() -> WebViewController {
        return WebViewController()
    }

    func buildLanguages() throws -> LanguagesViewController {
        let storyboard = UIStoryboard(name: "LanguagesView", bundle: Bundle(for: PresentationUIHandler.self))

        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LanguagesViewController") as? LanguagesViewController else {
            throw GetivySDKError.couldNotLoadViewFromStoryboard
        }

        return viewController
    }
}
