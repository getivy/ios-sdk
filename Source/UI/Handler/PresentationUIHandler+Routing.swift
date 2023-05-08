import Foundation

extension PresentationUIHandler {
    func presentBankView(animated: Bool) {
        let viewControllers = [buildBankView()]
        mainNavigationController.setViewControllers(viewControllers, animated: animated)
    }

    func presentWebView(bankId: String, animated: Bool) {
        let viewControllers = [buildBankView()]
        mainNavigationController.setViewControllers(viewControllers, animated: animated)
    }
}
