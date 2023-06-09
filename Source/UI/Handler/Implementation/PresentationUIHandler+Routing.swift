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
        guard let webView = try? buildWebView(bankId: bankId) else {
            print("Getivy: Error loading web view")
            return
        }

        if self.bankId == nil {
            mainNavigationController.pushViewController(webView, animated: true)
        } else {
            mainNavigationController.setViewControllers([webView], animated: animated)
        }
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

    func closeWithNonRecoverable(error: Error) {
        dismissUI()
        let sdkError = error as? SDKErrorImpl ?? SDKErrorImpl(
            code: SDKErrorCodes.flowCancelled.rawValue,
            message: SDKErrorCodes.flowCancelled.message()
        )
        config.onError(sdkError)
    }

    func dismissUI() {
        if presentationStyle == .simple {
            mainNavigationController.dismiss(animated: true)
        } else {
            dismissalHandler?(mainNavigationController)
        }
    }

    func goBackOrClose() {
        guard bankId == nil else {
            config.onError(
                SDKErrorImpl(
                    code: SDKErrorCodes.flowCancelled.rawValue,
                    message: SDKErrorCodes.flowCancelled.message()
                )
            )
            dismissUI()
            return
        }

        goBack()
    }
}
