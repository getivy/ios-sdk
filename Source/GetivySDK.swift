import Foundation

public typealias SuccessCallback = () -> Void

public typealias ErrorCallback = () -> Void

@objc
public final class GetivySDK: NSObject {
    @objc
    public static let shared = GetivySDK()

    var successCallback: SuccessCallback?

    var errorCallback: ErrorCallback?

    private let api: DataSessionApiService

    override private init() {
        api = DataSessionApiService(
            context: NonPersistentApiContext(environment: .production),
            session: URLSession.shared,
            parser: GetDataSessionResponseParser()
        )
        super.init()
    }

    @objc
    public func initializeHandler(
        id: String,
        environment: Environment,
        onSuccess: @escaping SuccessCallback,
        onError: @escaping ErrorCallback,
        handlerResult: @escaping (UIHandler?, Error?) -> Void
    ) {
        api.context.environment = environment
        successCallback = onSuccess
        errorCallback = onError

        let request = GetDataSessionRequest(id: id)
        api.retrieveDataSession(
            route: DataSessionApiRoute.retrieve,
            params: request
        ) { [weak self] result in
            switch result {
            case let .success(result):
                let uiHandler = PresentationUIHandler(bankId: result.prefill.bankId)
                handlerResult(uiHandler, nil)

            case let .failure(error):
                handlerResult(nil, error)
                self?.errorCallback?()
            }
        }
    }
}
