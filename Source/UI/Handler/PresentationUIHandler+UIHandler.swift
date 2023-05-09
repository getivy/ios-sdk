import UIKit

extension PresentationUIHandler: UIHandler {
    func openUI(
        viewController: UIViewController
    ) {
        viewController.present(mainNavigationController, animated: true) { [weak self] in
            self?.config.onExit()
        }
    }

    func openUI(
        presentationCosure: ViewControllerClosure,
        dismissalClosure: @escaping DismissalClosure = { $0.presentingViewController?.dismiss(animated: true, completion: nil) }
    ) {
        presentationCosure(mainNavigationController)
        dismissalHandler = dismissalClosure
    }
}
