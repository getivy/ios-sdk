import UIKit
import WebKit

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https" && url.scheme != "about" {
            // Disable this feature as we are currently not using any universal links
            // will throw an error if this is attempted in the future so its clear of what is going on
            router.closeWithNonRecoverable(error: GetivySDKError.featureWantedExternalBrowser)
            // Forward custom URL scheme deep linking to system open URL APIs
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil
        } else {
            // Handle opening pop-ups and new windows
            let newWebView = WKWebView(frame: webView.frame, configuration: configuration)
            newWebView.uiDelegate = self
            view.addSubview(newWebView)
            newWebView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                newWebView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                newWebView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                newWebView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            ])
            return newWebView
        }
    }

    func webViewDidClose(_ webView: WKWebView) {
        // Handle closing pop-ups and new windows
        webView.removeFromSuperview()
    }
}
