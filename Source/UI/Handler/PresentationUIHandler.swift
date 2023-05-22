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

    let closeButton: UIButton

    var dismissalHandler: DismissalClosure?

    init(config: GetivyConfiguration, bankId: String?, market: String) {
        self.bankId = bankId
        self.config = config
        self.market = market
        closeButton = UIButton(type: .custom)

        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: languageChangedNotification, object: nil)

        setupView()
        languageChanged()
        startFlow()
    }

    func setupView() {
        mainNavigationController.setNavigationBarHidden(true, animated: false)
        mainNavigationController.view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(didPressClose), for: .touchUpInside)
        closeButton.setTitleColor(.black, for: .normal)

        let margin: CGFloat = 16
        closeButton.isHidden = true

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: mainNavigationController.view.safeAreaLayoutGuide.topAnchor, constant: margin),
            closeButton.trailingAnchor.constraint(equalTo: mainNavigationController.view.trailingAnchor, constant: -margin),
        ])
    }

    @objc
    func didPressClose() {
        closeWithNonRecoverable(error: GetivySDKError.flowNotSuccessful)
    }

    @objc
    func languageChanged() {
        let language = Languages(rawValue: getLocale() ?? Languages.english.rawValue) ?? .english
        let closeTitle = "cancel".localized(language: language)
        closeButton.setTitle(closeTitle, for: .normal)
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
        case .error:
            config.onError(
                SDKErrorImpl(
                    code: SDKErrorCodes.paymentFailed.rawValue,
                    message: SDKErrorCodes.paymentFailed.message()
                )
            )
            dismissUI()
        }
    }
}
