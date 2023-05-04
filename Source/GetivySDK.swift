import Foundation

@objc
public final class GetivySDK: NSObject {
    private let api: DataSessionService

    @objc
    public init(environment: Environment) {
        api = DataSessionApiService(
            context: NonPersistentApiContext(environment: environment),
            session: URLSession.shared,
            parser: GetDataSessionResponseParser()
        )

        super.init()
    }

    @objc
    public func initializeHandler(
        id: String,
        completion: @escaping (PresentationUIHandler?, Error?) -> Void
    ) {
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
