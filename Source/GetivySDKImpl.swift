import UIKit

final class GetivySDKImpl {
    let api: DataSessionService & ApiService

    init(api: DataSessionService & ApiService) {
        self.api = api

        registerFonts()
    }

    func registerFonts() {
        UIFont.ivy_registerFont(withFilenameString: "GraphikRegular.otf")
        UIFont.ivy_registerFont(withFilenameString: "GraphikSemibold.otf")
        UIFont.ivy_registerFont(withFilenameString: "Inter-Regular.otf")
    }
}
