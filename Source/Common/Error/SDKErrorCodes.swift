import Foundation

enum SDKErrorCodes: String { case
    missingDataSessionId = "A40-iOS",
    wrongEnvironment = "A41-iOS",
    couldNotGetDataSession = "A42-iOS",
    flowCancelled = "A50-iOS",
    flowFailed = "A51-iOS"

    func message() -> String {
        switch self {
        case .missingDataSessionId:
            return "Data session id is empty."
        case .wrongEnvironment:
            return "Wrong environment provided."
        case .couldNotGetDataSession:
            return "Could not get data session."
        case .flowCancelled:
            return "Process was cancelled."
        case .flowFailed:
            return "Flow not successful."
        }
    }
}
