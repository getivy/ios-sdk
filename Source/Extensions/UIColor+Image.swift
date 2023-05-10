import UIKit

extension UIColor {
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")

        if hexString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    func imageWithInitial(_ initial: String, size: CGSize, textColor: UIColor, font: UIFont) -> UIImage {
        let frame = CGRect(origin: .zero, size: size)

        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = self
        nameLabel.textColor = textColor
        nameLabel.font = font
        nameLabel.text = initial.uppercased()

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }

        nameLabel.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()

        // Create a new image view to display the image
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2.0 // Set the corner radius to half

        // Render the circular image view to an image
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context2 = UIGraphicsGetCurrentContext() else { return UIImage() }

        imageView.layer.render(in: context2)
        let circularImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()

        return circularImage
    }
}
