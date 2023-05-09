import Foundation

public typealias SuccessCallback = () -> Void

public typealias ErrorCallback = () -> Void

public typealias OnExitCallback = () -> Void

@objcMembers
public
class GetivyConfiguration: NSObject {
    public let environment: Environment

    public let dataSessionId: String

    public var onSuccess: SuccessCallback
    
    public var onExit: OnExitCallback

    public var onError: ErrorCallback

    public init(
        dataSessionId: String,
        environment: Environment,
        onExit: @escaping OnExitCallback,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback
    ) {
        self.dataSessionId = dataSessionId
        self.environment = environment
        self.onExit = onExit
        self.onSuccess = onSuccess
        self.onError = onError
    }
}
