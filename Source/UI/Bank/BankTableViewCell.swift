import UIKit

class BankTableViewCell: UITableViewCell {
    @IBOutlet var bankNameLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bankNameLabel.font = UIFont(name: "Graphik-Regular", size: 16)
    }

    func setup(item: BankDetails) {
        let itemName = item.group ?? item.name
        bankNameLabel.text = itemName
        let imageSize = 42
        let fontSizeForLetter: CGFloat = 20
        logoImageView.image = UIColor(hexString: "#BDBDBD")?
            .imageWithInitial(String(itemName.first ?? "B"),
                              size: CGSize(width: imageSize, height: imageSize),
                              textColor: .white,
                              font: UIFont(name: "Graphik-Regular", size: fontSizeForLetter) ?? UIFont())
        logoImageView.load(url: URL(string: item.logo))
    }
}
