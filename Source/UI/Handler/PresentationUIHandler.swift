import Foundation
import UIKit

@objcMembers
public class PresentationUIHandler: NSObject, UIHalnder {
    func openUI(
        viewController _: UIViewController,
        onSuccess _: () -> Void,
        onError _: () -> Void
    ) {}

    func openUI(
        presentationCosure _: ViewControllerClosure,
        dismissalClosure _: DismissalClosure = { $0.presentingViewController?.dismiss(animated: true, completion: nil) },
        onSuccess _: () -> Void,
        onError _: () -> Void
    ) {}
}
