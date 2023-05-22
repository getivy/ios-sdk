import Foundation

enum SDKErrorCodes: String { case
    missingDataSessionId = "A40-iOS",
    couldNotGetDataSession = "A42-iOS",
    flowCancelled = "A50-iOS",
    paymentFailed = "A52-iOS"

    func message() -> String {
        switch self {
        case .missingDataSessionId:
            return "Data session id is empty."
        case .couldNotGetDataSession:
            return "Could not get data session."
        case .flowCancelled:
            return "Process was cancelled."
        case .paymentFailed:
            return "Payment not successful."
        }
    }
}
