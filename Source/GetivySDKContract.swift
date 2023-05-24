import UIKit

public typealias HandlerCompletion = (UIHandler?, SDKError?) -> Void

protocol GetivySDKContract {
    func initializeHandler(
        configuration: GetivyConfiguration,
        handlerResult: @escaping HandlerCompletion
    )
}
