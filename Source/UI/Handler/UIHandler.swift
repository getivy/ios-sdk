import Foundation
import UIKit

typealias DismissalClosure = (UIViewController) -> Void

typealias ViewControllerClosure = (UIViewController) -> Void

@objc
protocol UIHalnder {
    func openUI(
        viewController: UIViewController,
        onSuccess: () -> Void,
        onError: () -> Void
    )

    func openUI(
        presentationCosure: ViewControllerClosure,
        dismissalClosure: DismissalClosure,
        onSuccess: () -> Void,
        onError: () -> Void
    )
}
