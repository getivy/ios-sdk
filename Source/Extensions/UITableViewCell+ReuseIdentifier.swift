import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        let classString = NSStringFromClass(self)
        let components = classString.components(separatedBy: ".")
        guard let className = components.last else { return classString }
        return className
    }
}
