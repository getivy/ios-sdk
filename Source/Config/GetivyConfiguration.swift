import Foundation

public typealias SuccessCallback = () -> Void

public typealias ErrorCallback = () -> Void

@objcMembers
public
class GetivyConfiguration: NSObject {
    public let environment: Environment

    public let dataSessionId: String

    public var onSuccess: SuccessCallback

    public var onError: ErrorCallback

    public init(
        dataSessionId: String,
        environment: Environment,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback
    ) {
        self.dataSessionId = dataSessionId
        self.environment = environment
        self.onSuccess = onSuccess
        self.onError = onError
    }
}
