import Foundation
import UIKit

@objc
class PresentationUIHandler: NSObject {
    var masterNavigationController = UINavigationController()
    var bankId: String?

    override private init() { super.init() }

    init(bankId: String?) {
        self.bankId = bankId

        super.init()
    }
}

extension PresentationUIHandler: UIHandler {
    func openUI(
        viewController _: UIViewController
    ) {}

    func openUI(
        presentationCosure _: ViewControllerClosure,
        dismissalClosure _: DismissalClosure = { $0.presentingViewController?.dismiss(animated: true, completion: nil) }
    ) {}
}
