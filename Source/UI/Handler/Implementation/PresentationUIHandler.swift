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

    let localizationManager: LocalizationManagerContract

    var dismissalHandler: DismissalClosure?

    init(config: GetivyConfiguration, bankId: String?, market: String, locale: String?) {
        self.bankId = bankId
        self.config = config
        self.market = market
        localizationManager = LocalizationManager(userDefaults: UserDefaults.standard, initialLocale: locale)

        super.init()

        setupView()
        startFlow()
    }

    func setupView() {
        mainNavigationController.setNavigationBarHidden(true, animated: false)
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
        switch result.value {
        case .success:
            let details = SuccessDetails(referenceId: result.referenceId, dataSessionId: result.dataId)
            config.onSuccess(details)
            dismissUI()
        case .cancel:
            goBackOrClose()
        case .error:
            config.onError(
                SDKErrorImpl(
                    code: SDKErrorCodes.flowFailed.rawValue,
                    message: SDKErrorCodes.flowFailed.message()
                )
            )
            dismissUI()
        }
    }
}
