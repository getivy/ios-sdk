import Foundation

@objc
public final class GetivySDK: NSObject {
    @objc
    public static let shared = GetivySDK()

    private let api = DataSessionApiService(
        context: NonPersistentApiContext(environment: .production),
        session: URLSession.shared,
        parser: GetDataSessionResponseParser()
    )

    override private init() { super.init() }

    @objc
    public func initializeHandler(
        id: String,
        environment: Environment,
        completion: @escaping (UIHandler?, Error?) -> Void
    ) {
        api.context.environment = environment

        let request = GetDataSessionRequest(id: id)
        api.retrieveDataSession(
            route: DataSessionApiRoute.retrieve,
            params: request
        ) { result in
            switch result {
            case let .success(result):
                let uiHandler = PresentationUIHandler()
                completion(uiHandler, nil)

            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
