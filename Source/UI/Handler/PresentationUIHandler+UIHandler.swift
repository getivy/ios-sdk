import UIKit

extension PresentationUIHandler: UIHandler {
    func openUI(
        viewController: UIViewController
    ) {
        presentationStyle = .simple
        viewController.present(mainNavigationController, animated: true)
    }

    func openUI(
        presentationCosure: ViewControllerClosure,
        dismissalClosure: @escaping DismissalClosure = { $0.presentingViewController?.dismiss(animated: true, completion: nil) }
    ) {
        presentationStyle = .custom
        presentationCosure(mainNavigationController)
        dismissalHandler = dismissalClosure
    }
}
