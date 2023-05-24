import UIKit

final class GetivySDKImpl {
    let api: DataSessionService & ApiService

    init(api: DataSessionService & ApiService) {
        self.api = api

        registerFonts()
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

    func registerFonts() {
        UIFont.ivy_registerFont(withFilenameString: "GraphikRegular.otf")
        UIFont.ivy_registerFont(withFilenameString: "GraphikSemibold.otf")
        UIFont.ivy_registerFont(withFilenameString: "Inter-Regular.otf")
    }
}

extension GetivySDKImpl: GetivySDKContract {
    func initializeHandler(
        configuration: GetivyConfiguration,
        handlerResult: @escaping HandlerCompletion
    ) {
        if let error = configuration.validate() {
            handlerResult(nil, error)
            configuration.onError(error)
        }

        api.context.environment = configuration.environment

        let request = GetDataSessionRequest(id: configuration.dataSessionId)
        api.retrieveDataSession(
            route: DataSessionApiRoute.retrieve,
            params: request
        ) { [weak self] result in
            switch result {
            case let .success(result):

                self?.changeLanguageIfNeeded(response: result)

                let uiHandler = PresentationUIHandler(
                    config: configuration,
                    bankId: result.prefill.bankId,
                    market: result.market
                )
                DispatchQueue.main.async {
                    handlerResult(uiHandler, nil)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    let sdkError = error as? SDKErrorImpl ??
                        SDKErrorImpl(
                            code: SDKErrorCodes.couldNotGetDataSession.rawValue,
                            message: SDKErrorCodes.couldNotGetDataSession.message()
                        )
                    handlerResult(nil, sdkError)
                    configuration.onError(sdkError)
                }
            }
        }
    }
}
