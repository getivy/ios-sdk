@testable import GetivySDK
import XCTest

class GetivySDKImplTests: XCTestCase {
    func test_givenDataSessionService_whenGetivySDKImplInitialized_thenFontShouldBecomeAvailable() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        // When
        _ = GetivySDKImpl(api: api)

        // Then
        let fontNamesForGraphik = UIFont.fontNames(forFamilyName: "Graphik")
        let fontNamesForInter = UIFont.fontNames(forFamilyName: "Inter")
        XCTAssertTrue(fontNamesForGraphik.contains(["Graphik-Regular", "Graphik-Semibold"]))
        XCTAssertTrue(fontNamesForInter.contains(["Inter-Regular"]))
    }

    func test_givenDataSessionService_whenInitializeHandlerMethodIsCalled_thenConfigShouldBeValidated() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let sdk = GetivySDKImpl(api: api)
        let config = GetivyConfigurationSpy(dataSessionId: "") { result in } onError: { error in }

        // When
        sdk.initializeHandler(configuration: config) { handler, error in }

        // Then
        XCTAssertEqual(config.invokedValidateCount, 1)
    }

    func test_givenSDK_whenInvalidSessionIsSet_thenOnErrorShouldBeCalled() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let sdk = GetivySDKImpl(api: api)
        var reportedHandlerError: SDKError?
        var reportedOnError: SDKError?
        let config = GetivyConfigurationSpy(dataSessionId: "") { result in } onError: { error in }
        let error = SDKErrorImpl(code: SDKErrorCodes.flowCancelled.rawValue, message: "Message")
        config.stubbedValidateResult = error
        config.stubbedOnError = { error in
            reportedOnError = error
        }

        // When
        sdk.initializeHandler(configuration: config) { handler, error in
            reportedHandlerError = error
        }

        // Then
        XCTAssertEqual(error.code, reportedOnError?.code)
        XCTAssertEqual(error.message, reportedOnError?.message)
        XCTAssertEqual(error.code, reportedHandlerError?.code)
        XCTAssertEqual(error.message, reportedHandlerError?.message)
    }

    func test_givenSDK_whenEnvironmentChanges_thenChangeApiServiceEnvironment() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let sdk = GetivySDKImpl(api: api)
        let config = GetivyConfigurationSpy(dataSessionId: "", environment: .production) { result in } onError: { error in }
        // When
        sdk.initializeHandler(configuration: config) { handler, error in
        }

        // Then
        XCTAssertEqual(api.context.environment, .production)
    }

    func test_givenSDK_whenDataSessionSucceeds_thenHandlerShouldBeReturned() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let dataSessionId = "asdf"
        let bankId = "bid"
        let market = "market"
        let locale = "locale"
        let bankInfo = BankInformation(bankId: bankId)
        let response = GetDataSessionResponse(id: dataSessionId, locale: locale, prefill: bankInfo, market: market)
        api.stubbedRetrieveDataSessionCompletionResult = (.success(response), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: dataSessionId) { result in } onError: { error in }

        let expectation = expectation(description: "Handler returned successfully")

        // When
        var resultHandler: UIHandler?
        sdk.initializeHandler(configuration: config) { handler, error in
            resultHandler = handler
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
        guard let handler = resultHandler as? PresentationUIHandler else {
            XCTAssert(false)
            return
        }

        XCTAssertEqual(handler.bankId, bankId)
        XCTAssertEqual(handler.market, market)
        XCTAssertEqual(handler.localizationManager.getLocaleCode(), locale)
        XCTAssertEqual(handler.config, config)
    }

    func test_givenSDK_whenDataSessionSucceeds_thenHandlerShouldBeReturned2() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let dataSessionId = "Other result"
        let bankId = "smth else"
        let market = "changed"
        let locale = "another locale"
        let bankInfo = BankInformation(bankId: bankId)
        let response = GetDataSessionResponse(id: dataSessionId, locale: locale, prefill: bankInfo, market: market)
        api.stubbedRetrieveDataSessionCompletionResult = (.success(response), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: dataSessionId) { result in } onError: { error in }

        let expectation = expectation(description: "Handler returned successfully2")

        // When
        var resultHandler: UIHandler?
        sdk.initializeHandler(configuration: config) { handler, error in
            resultHandler = handler
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
        guard let handler = resultHandler as? PresentationUIHandler else {
            XCTAssert(false)
            return
        }

        XCTAssertEqual(handler.bankId, bankId)
        XCTAssertEqual(handler.market, market)
        XCTAssertEqual(handler.localizationManager.getLocaleCode(), locale)
        XCTAssertEqual(handler.config, config)
    }

    func test_givenSDK_whenDataSessionFails_thenCompletionCalledOnMainThread() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )
        let dataSessionId = "1"
        let bankId = "2"
        let market = "3"
        let locale = "4"
        let bankInfo = BankInformation(bankId: bankId)
        let response = GetDataSessionResponse(id: dataSessionId, locale: locale, prefill: bankInfo, market: market)
        api.stubbedRetrieveDataSessionCompletionResult = (.success(response), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: dataSessionId) { result in } onError: { error in }

        let expectation = expectation(description: "Handler returned successfully2")

        // When
        var isMainThread = false
        sdk.initializeHandler(configuration: config) { handler, error in
            isMainThread = Thread.isMainThread
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(isMainThread)
    }

    func test_givenSDK_whenDataSessionFails_thenOnErrorShouldBeCalled() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )

        let error = NSError(domain: "1", code: 1)

        api.stubbedRetrieveDataSessionCompletionResult = (.failure(error), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: "dataSessionId") { result in } onError: { error in
        }
        var onError: SDKError?
        config.stubbedOnError = { error in
            onError = error
        }

        let expectation = expectation(description: "failed to get handler")

        // When
        var sdkError: SDKError?
        sdk.initializeHandler(configuration: config) { handler, error in
            sdkError = error
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(onError?.code, SDKErrorCodes.couldNotGetDataSession.rawValue)
        XCTAssertEqual(onError?.message, SDKErrorCodes.couldNotGetDataSession.message())
        XCTAssertEqual(sdkError?.code, SDKErrorCodes.couldNotGetDataSession.rawValue)
        XCTAssertEqual(sdkError?.message, SDKErrorCodes.couldNotGetDataSession.message())
    }

    func test_givenSDK_whenDataSessionFails_thenOnErrorShouldBeCalled2() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )

        let error = SDKErrorImpl(code: SDKErrorCodes.missingDataSessionId.rawValue, message: SDKErrorCodes.missingDataSessionId.message())

        api.stubbedRetrieveDataSessionCompletionResult = (.failure(error), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: "dataSessionId") { result in } onError: { error in
        }
        var onError: SDKError?
        config.stubbedOnError = { error in
            onError = error
        }

        let expectation = expectation(description: "failed to get handler 2")

        // When
        var sdkError: SDKError?
        sdk.initializeHandler(configuration: config) { handler, error in
            sdkError = error
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(onError?.code, SDKErrorCodes.missingDataSessionId.rawValue)
        XCTAssertEqual(onError?.message, SDKErrorCodes.missingDataSessionId.message())
        XCTAssertEqual(sdkError?.code, SDKErrorCodes.missingDataSessionId.rawValue)
        XCTAssertEqual(sdkError?.message, SDKErrorCodes.missingDataSessionId.message())
    }

    func test_givenSDK_whenDataSessionFails_thenOnErrorShouldBeCalledOnMainThread() {
        // Given
        let api = DataSessionServiceSpy(
            context: NonPersistentApiContext(environment: .sandbox),
            session: URLSession.shared
        )

        let error = SDKErrorImpl(code: SDKErrorCodes.missingDataSessionId.rawValue, message: SDKErrorCodes.missingDataSessionId.message())

        api.stubbedRetrieveDataSessionCompletionResult = (.failure(error), ())
        let sdk = GetivySDKImpl(api: api)

        let config = GetivyConfigurationSpy(dataSessionId: "dataSessionId") { result in } onError: { error in
        }
        var isMainThreadOnError = false
        config.stubbedOnError = { error in
            isMainThreadOnError = Thread.isMainThread
        }

        let expectation = expectation(description: "failed to get handler 2")

        // When
        var isMainThreadCompletion = false
        sdk.initializeHandler(configuration: config) { handler, error in
            isMainThreadCompletion = Thread.isMainThread
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)

        XCTAssertTrue(isMainThreadCompletion)
        XCTAssertTrue(isMainThreadOnError)
    }
}
