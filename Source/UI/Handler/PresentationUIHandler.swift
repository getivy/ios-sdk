import UIKit

class PresentationUIHandler: NSObject {
    var mainNavigationController = UINavigationController()
    var bankId: String?

    var dismissalHandler: DismissalClosure?

    override private init() { super.init() }

    init(bankId: String?) {
        self.bankId = bankId

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
