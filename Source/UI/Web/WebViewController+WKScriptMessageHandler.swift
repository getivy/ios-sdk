import WebKit

extension WebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dictionary = message.body as? [String: AnyObject],
              let source = dictionary["source"] as? String,
              let sourceEnum = WebMessageSource(rawValue: source),
              let type = dictionary["type"] as? String,
              let typeEnum = WebMessageType(rawValue: type),
              let refId = dictionary["referenceId"] as? String, let dataId = dictionary["dataId"] as? String,
              let value = dictionary["value"] as? String,
              let outcome = WebMessageOutcome(rawValue: value) else {
            return
        }

        let result = WebResult(
            dataId: dataId,
            referenceId: refId,
            source: sourceEnum,
            type: typeEnum,
            value: outcome
        )

        router.handleWebResult(result: result)
    }
}
