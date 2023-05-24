import UIKit

@objcMembers
public final class GetivySDK: NSObject {
    public static let shared = GetivySDK()

    private var sdk: GetivySDKContract

    override internal init() {
        sdk = GetivySDKImpl(
            api: DataSessionApiService(
                context: NonPersistentApiContext(environment: .production),
                session: URLSession.shared,
                parser: DataSessionResponseParser()
            )
        )
        super.init()
    }

    public func initializeHandler(
        configuration: GetivyConfiguration,
        handlerResult: @escaping HandlerCompletion
    ) {
        sdk.initializeHandler(configuration: configuration, handlerResult: handlerResult)
    }
}
