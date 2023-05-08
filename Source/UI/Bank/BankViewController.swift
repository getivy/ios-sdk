import UIKit

class BankViewController: UIViewController {
    let kFontSize: CGFloat = 25

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // Create a label and set its properties
        let label = UILabel()
        label.text = "Bank view"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: kFontSize)

        // Add the label to the view controller's view
        view.addSubview(label)

        // Set the constraints for the label to be centered in the view
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
