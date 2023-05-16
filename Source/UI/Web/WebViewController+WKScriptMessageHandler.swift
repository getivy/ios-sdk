import WebKit

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageString = message.body as? String,
              let dictionary = try? JSONSerialization.jsonObject(with: Data(messageString.utf8)) as? [String: AnyObject],
              let source = dictionary["source"] as? String,
              let sourceEnum = WebMessageSource(rawValue: source),
              let type = dictionary["type"] as? String,
              let typeEnum = WebMessageType(rawValue: type),
              let value = dictionary["value"] as? String,
              let outcome = WebMessageOutcome(rawValue: value) else {
            return
        }

        let result = WebResult(
            dataId: dictionary["dataId"] as? String,
            referenceId: dictionary["referenceId"] as? String,
            source: sourceEnum,
            type: typeEnum,
            value: outcome
        )

        router.handleWebResult(result: result)
    }
}
