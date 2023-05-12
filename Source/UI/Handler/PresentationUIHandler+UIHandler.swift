import UIKit

extension PresentationUIHandler: UIHandler {
    func openUI(
        viewController: UIViewController
    ) {
        presentationStyle = .simple
        mainNavigationController.modalPresentationStyle = .overFullScreen
        mainNavigationController.modalTransitionStyle = .coverVertical
        viewController.present(mainNavigationController, animated: true)
    }

    func openUI(
        presentationCosure: ViewControllerClosure,
        dismissalClosure: @escaping DismissalClosure
    ) {
        presentationStyle = .custom
        presentationCosure(mainNavigationController)
        dismissalHandler = dismissalClosure
    }
}
