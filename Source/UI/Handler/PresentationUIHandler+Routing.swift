import UIKit

extension PresentationUIHandler {
    func presentBankView(animated: Bool, group: String? = nil) {
        guard let bankView = try? buildBankView() else {
            print("Getivy: Error loading bank view")
            return
        }

        bankView.group = group

        if group != nil {
            mainNavigationController.pushViewController(bankView, animated: animated)
        } else {
            let viewControllers = [bankView]
            mainNavigationController.setViewControllers(viewControllers, animated: animated)
        }
    }

    func presentWebView(bankId: String, animated: Bool) {
        let viewControllers = [buildWebView()]
        mainNavigationController.setViewControllers(viewControllers, animated: animated)
    }

    func presentLanguagesView(over view: UIView) {
        guard let languagesView = try? buildLanguages() else {
            print("Getivy: Error loading languages view")
            return
        }

        let width = 155
        let height = 123

        presentPopover(mainNavigationController, languagesView, sender: view, size: CGSize(width: width, height: height))
    }

    func goBack() {
        mainNavigationController.popViewController(animated: true)
    }
}
