import Foundation

extension GetivySDKImpl: GetivySDKContract {
    func initializeHandler(
        configuration: GetivyConfiguration,
        handlerResult: @escaping HandlerCompletion
    ) {
        if let error = configuration.validate() {
            handlerResult(nil, error)
            configuration.onError(error)
            return
        }

        guard let environment = Environment(rawValue: configuration.environment) else {
            return // Should have been already checked in the previous validate call
        }

        api.context.environment = environment

        let request = GetDataSessionRequest(id: configuration.dataSessionId)
        api.retrieveDataSession(
            route: DataSessionApiRoute.retrieve,
            params: request
        ) { result in
            switch result {
            case let .success(result):

                let uiHandler = PresentationUIHandler(
                    config: configuration,
                    bankId: result.prefill.bankId,
                    market: result.market,
                    locale: result.locale
                )
                DispatchQueue.main.async {
                    handlerResult(uiHandler, nil)
                }
            case let .failure(error):

                let sdkError = error as? SDKErrorImpl ??
                    SDKErrorImpl(
                        code: SDKErrorCodes.couldNotGetDataSession.rawValue,
                        message: SDKErrorCodes.couldNotGetDataSession.message()
                    )
                DispatchQueue.main.async {
                    handlerResult(nil, sdkError)
                    configuration.onError(sdkError)
                }
            }
        }
    }
}
