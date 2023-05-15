import UIKit

enum PresentationStyle {
    case simple
    case custom
}

class PresentationUIHandler: NSObject {
    var mainNavigationController = UINavigationController()
    var bankId: String?
    var market: String

    var presentationStyle = PresentationStyle.simple

    let config: GetivyConfiguration

    var dismissalHandler: DismissalClosure?

    init(config: GetivyConfiguration, bankId: String?, market: String) {
        self.bankId = bankId
        self.config = config
        self.market = market

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

    func handleWebResult(result: WebResult) {
        dismissUI()

        if result.value == .success {
            let details = SuccessDetails(referenceId: result.referenceId, dataSessionId: result.dataId)
            config.onSuccess(details)
        } else {
            config.onError(GetivySDKNonRecoverableError.flowNotSuccessful)
        }
    }

    func dismissUI() {
        if presentationStyle == .simple {
            mainNavigationController.dismiss(animated: true)
        } else {
            dismissalHandler?(mainNavigationController)
        }
    }
}
