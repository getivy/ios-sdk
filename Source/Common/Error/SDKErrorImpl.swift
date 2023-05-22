import Foundation

class SDKErrorImpl: SDKError, Error {
    let code: String
    let message: String

    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}
