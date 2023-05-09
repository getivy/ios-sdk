import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    var bankId: String!
    var router: PresentationUIHandler!

    override func viewDidLoad() {
        super.viewDidLoad()

        let webApiRoute = WebViewApiRoute.load(dataSessionId: router.config.dataSessionId, bankId: bankId)
        guard let url = webApiRoute.paymentUrl(for: router.config.environment) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
