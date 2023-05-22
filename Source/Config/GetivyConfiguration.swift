import Foundation

public typealias SuccessCallback = (_ result: Details) -> Void

public typealias ErrorCallback = (_ error: SDKError?) -> Void

@objcMembers
public
class GetivyConfiguration: NSObject {
    public let environment: Environment

    public let dataSessionId: String

    public var onSuccess: SuccessCallback

    public var onError: ErrorCallback

    public init(
        dataSessionId: String,
        environment: Environment = .production,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback
    ) {
        self.dataSessionId = dataSessionId
        self.environment = environment
        self.onSuccess = onSuccess
        self.onError = onError
    }

    func validate() -> SDKErrorImpl? {
        if dataSessionId.isEmpty {
            return SDKErrorImpl(
                code: SDKErrorCodes.missingDataSessionId.rawValue,
                message: SDKErrorCodes.missingDataSessionId.message()
            )
        }

        return nil
    }
}
