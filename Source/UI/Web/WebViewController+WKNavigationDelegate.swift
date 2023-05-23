import UIKit
import WebKit

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https" {
            // Disable for now as we are not using any universal links so will throw an error if this is attempted in the future to indicate
            // of what is going on
            router.closeWithNonRecoverable(error: GetivySDKError.featureWantedExternalBrowser)
//            // Forward custom URL scheme deep linking to system open URL APIs
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
