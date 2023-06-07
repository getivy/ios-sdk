import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var webView: WKWebView!

    private let decoder = JSONDecoder()

    var bankId: String!
    var router: PresentationUIHandler!

    deinit {
        router.localizationManager.removeObserver(observer: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        router.localizationManager.addObserver(observer: self)
        didChangeLanguage(code: router.localizationManager.getLocaleCode())

        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "nativeMessageListener")

        let webApiRoute = WebViewApiRoute.load(
            dataSessionId: router.config.dataSessionId,
            bankId: bankId,
            locale: router.localizationManager.getLocaleCode()
        )

        guard let environment = Environment(rawValue: router.config.environment) else {
            assertionFailure() // Should never happen
            return
        }

        guard let url = webApiRoute.paymentUrl(for: environment) else {
            return
        }

        webView.navigationDelegate = self
        webView.uiDelegate = self

        let request = URLRequest(url: url)
        webView.load(request)

        closeButton.setTitleColor(.black, for: .normal)

        // Needed for web view to be inspectable in debug
        #if DEBUG && swift(>=5.8)
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        #endif
    }

    @IBAction func didPressClose() {
        router.goBackOrClose()
    }
}
