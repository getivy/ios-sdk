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

    let localizationManager: LocalizationManagerContract

    var dismissalHandler: DismissalClosure?

    init(config: GetivyConfiguration, bankId: String?, market: String, locale: String?) {
        self.bankId = bankId
        self.config = config
        self.market = market
        localizationManager = LocalizationManager(userDefaults: UserDefaults.standard, initialLocale: locale)
        closeButton = UIButton(type: .custom)

        super.init()

        localizationManager.addObserver(observer: self)
        setupView()
        didChangeLanguage(code: localizationManager.getLocaleCode())
        startFlow()
    }

    deinit {
        localizationManager.removeObserver(observer: self)
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
        goBackOrClose()
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
