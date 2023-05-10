import UIKit

class PresentationUIHandler: NSObject {
    var mainNavigationController = UINavigationController()
    var bankId: String?

    let config: GetivyConfiguration

    var dismissalHandler: DismissalClosure?

    init(config: GetivyConfiguration, bankId: String?) {
        self.bankId = bankId
        self.config = config

        super.init()

        mainNavigationController.setNavigationBarHidden(true, animated: false)
        startFlow()
    }

    func startFlow() {
        if let bankId {
            presentWebView(
                bankId: bankId,
                animated: false
            )
        } else {
            presentBankView(animated: false)
        }
    }
}
