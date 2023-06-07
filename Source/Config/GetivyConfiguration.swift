import Foundation

public typealias SuccessCallback = (_ result: Details) -> Void

public typealias ErrorCallback = (_ error: SDKError?) -> Void

@objcMembers
public
class GetivyConfiguration: NSObject {
    public let environment: String

    public let dataSessionId: String

    public var onSuccess: SuccessCallback

    public var onError: ErrorCallback

    public init(
        dataSessionId: String,
        environment: String,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback
    ) {
        self.dataSessionId = dataSessionId
        self.environment = environment
        self.onSuccess = onSuccess
        self.onError = onError

        super.init()
    }

    public init(
        dataSessionId: String,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback
    ) {
        self.dataSessionId = dataSessionId
        environment = Environment.production.rawValue
        self.onSuccess = onSuccess
        self.onError = onError

        super.init()
    }

    func validate() -> SDKErrorImpl? {
        if dataSessionId.isEmpty {
            return SDKErrorImpl(
                code: SDKErrorCodes.missingDataSessionId.rawValue,
                message: SDKErrorCodes.missingDataSessionId.message()
            )
        }

        if !Environment.allCases.map(\.rawValue).contains(environment) {
            return SDKErrorImpl(
                code: SDKErrorCodes.wrongEnvironment.rawValue,
                message: SDKErrorCodes.wrongEnvironment.message()
            )
        }

        return nil
    }
}
