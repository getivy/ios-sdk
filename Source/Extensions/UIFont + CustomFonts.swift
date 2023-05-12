import UIKit

public extension UIFont {
    static func ivy_registerFont(withFilenameString filenameString: String, bundle: Bundle = Bundle(for: GetivySDK.self)) {
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("GetivySDK: UIFont+:  Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("GetivySDK: UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("GetivySDK: UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("GetivySDK: UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &errorRef) {
            print("""
                        GetivySDK: UIFont+:  Failed to register font - register graphics font failed - this
            font may have already been registered in the main bundle.
            """)
        }
    }
}
