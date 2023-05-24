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
}
