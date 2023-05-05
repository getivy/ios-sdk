import Foundation
import UIKit

public typealias DismissalClosure = (UIViewController) -> Void

public typealias ViewControllerClosure = (UIViewController) -> Void

@objc
public protocol UIHandler {
    func openUI(
        viewController: UIViewController
    )

    func openUI(
        presentationCosure: ViewControllerClosure,
        dismissalClosure: DismissalClosure
    )
}
