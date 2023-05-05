import Foundation

@objc
public final class GetivySDK: NSObject {
    @objc
    public static let shared = GetivySDK()

    var config: GetivyConfiguration?

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
        configuration: GetivyConfiguration,
        handlerResult: @escaping (UIHandler?, Error?) -> Void
    ) {
        api.context.environment = configuration.environment
        config = configuration

        let request = GetDataSessionRequest(id: configuration.dataSessionId)
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
                self?.config?.onError()
            }
        }
    }
}
