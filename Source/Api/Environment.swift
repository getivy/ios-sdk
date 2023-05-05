import Foundation

@objc
public enum Environment: Int {
    case production
    case sandbox
    case development

    var url: String {
        switch self {
        case .production:
            return "https://api.getivy.de"
        case .sandbox:
            return "https://api.sand.getivy.de"
        case .development:
            return "https://api.dev.getivy.de"
        }
    }
}
