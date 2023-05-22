import Foundation

@objc
public protocol SDKError {
    var code: String { get }
    var message: String { get }
}
