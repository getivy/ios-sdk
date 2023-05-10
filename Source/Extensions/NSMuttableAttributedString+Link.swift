import UIKit

extension NSMutableAttributedString {
    @discardableResult
    func setAsUnderlinedLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = mutableString.range(of: textToFind)

        if foundRange.location != NSNotFound {
            addAttribute(.link, value: linkURL, range: foundRange)
            addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: foundRange)
            return true
        }
        return false
    }
}
