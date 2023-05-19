import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    private let decoder = JSONDecoder()

    var bankId: String!
    var router: PresentationUIHandler!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        router.closeButton.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "nativeMessageListener")

        let webApiRoute = WebViewApiRoute.load(
            dataSessionId: router.config.dataSessionId,
            bankId: bankId,
            locale: getLocale() ?? Languages.english.rawValue
        )
        guard let url = webApiRoute.paymentUrl(for: router.config.environment) else {
            return
        }

        webView.navigationDelegate = self
        webView.uiDelegate = self

        let request = URLRequest(url: url)
        webView.load(request)

        // Needed for web view to be inspectable in debug
        #if DEBUG
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        #endif
    }
}
