import Foundation

@objc
public enum Environment: Int {
    case production
    case sandbox
    case development

    var url: String {
        switch self {
        case .production:
            assertionFailure("implement")
            return "https://api.dev.getivy.de"
        case .sandbox:
            assertionFailure("implement")
            return "https://api.sand.getivy.de"
        case .development:
            return "https://api.dev.getivy.de"
        }
    }
}
