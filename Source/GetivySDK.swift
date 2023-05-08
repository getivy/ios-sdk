import UIKit

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

        registerFonts()
    }

    func registerFonts() {
        UIFont.ivy_registerFont(withFilenameString: "GraphikRegular.otf")
        UIFont.ivy_registerFont(withFilenameString: "GraphikSemibold.otf")
        UIFont.ivy_registerFont(withFilenameString: "Inter-Regular.otf")
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

                self?.changeLanguageIfNeeded(response: result)

                let uiHandler = PresentationUIHandler(bankId: result.prefill.bankId)
                handlerResult(uiHandler, nil)

            case let .failure(error):
                handlerResult(nil, error)
                self?.config?.onError()
            }
        }
    }

    func changeLanguageIfNeeded(response: GetDataSessionResponse) {
        if getLocale() != nil {
            return
        }

        setLocale(code:
            response.locale ??
                Locale.current.languageCode ??
                Languages.english.rawValue
        )
    }
}
