![GetivySDK: slogan goes here]

1-2 sentence description what is GetivySDK?.

## Contents

* [Requirements]
* [Installation]
* [Start flow]
  + [Simple use case]
  + [More control]
  + [Testing in sandbox]
* [OnSuccess]
* [OnError]

## Requirements (for latest release)

* Xcode 13+
* Swift 5.0+

## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

Specify GetivySDK into your project's `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

pod 'GetivySDK'
```

Then run the following command:

```bash
$ pod install
```

#### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code.

After you set up your `Package.swift` manifest file, you can add GetivySDK as a dependency by adding it to the dependencies value of your `Package.swift`.

dependencies: [
    .package(url: "https://github.com/getivy/ios-sdk.git", from: "1.0.0")
]


#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

Specify GetivySDK into your project's `Cartfile`:

```ogdl
github "getivy/ios-sdk" ~> 1.0
```

#### Manually as Embedded Framework

* Clone GetivySDK as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command from your project root git folder.

```bash
$ git submodule add https://github.com/getivy/ios-sdk.git
```

* Open GetivySDK folder that was created by the previous git submodule command and drag the GetivySDK.xcodeproj into the Project Navigator of your application's Xcode project.

* Select the GetivySDK.xcodeproj in the Project Navigator and verify the deployment target matches with your application deployment target.

* Select your project in the Xcode Navigation and then select your application target from the sidebar. Next select the "General" tab and click on the + button under the "Embedded Binaries" section.

* Select `GetivySDK.framework` and we are done!


## Start flow

### How to create a form
By extending `FormViewController` you can then simply add sections and rows to the `form` variable.

```swift
import UIKit
import GetivySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Create an SDK configuration
        let config = GetivyConfiguration(
            dataSessionId: <data session id string>,
            onSuccess: { result in }, 
            onError: { error in }
        )
        
        // Get reference to the SDK
        let sdk = GetivySDK.shared
        
        // Get UI handler
        sdk.initializeHandler(configuration: config) { handler, error in
            handler?.openUI(viewController: self) // Set a view controller for SDK to present its UI over and start the flow
        }
    }
}
```

### More control

To control how the SDK UI is presented you can use an alternative call to present the UI handler:

```swift
import UIKit
import GetivySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Create an SDK configuration
        let config = GetivyConfiguration(
            dataSessionId: <data session id string>,
            onSuccess: { result in }, 
            onError: { error in }
        )
        
        // Get reference to the SDK
        let sdk = GetivySDK.shared
        
        // Get UI handler
        sdk.initializeHandler(configuration: config) { handler, error in
            handler?.openUI(presentationCosure: { sdkViewController in 
                // presentation closure will get called with a reference to the main SDK view controller so the app can control the presentation
            }, dismissalClosure: { sdkViewController in
                // dismiss callback insicates that sdk should be removed from the apps UI in case it finished or there was a non recoverable error
            })
        }
    }
}
```

### Testing in sandbox

For testing before release please specify extra environment argument in the configuration creation:

```swift
    // Create an SDK configuration
    let config = GetivyConfiguration(
        dataSessionId: <data session id string>,
        environment: .sandbox,
        onSuccess: { result in }, 
        onError: { error in }
    )
```
## OnSuccess

When creating SDK configuration, there is a callback onSuccess which is called in the event that user successfuly completed the flow. In this case the details of the even are returned in form of an object, containing the original data session id passed to the SDK to initiate the flow as well as reference id of the completed flow. 

## OnError

When creating SDK configuration, there is a callback onError which is called in the event where there was an error in the flow. Error object detailing the error will be present to action accordingly.



<!--- In file -->
[Requirements]: #requirements
[Installation]: #installation
[Start flow]: #start-flow
[Simple use case]: #simple-use-case
[More control]: #more-control
[Testing in sandbox]: #testing-in-sandbox
[OnSuccess]: #onsuccess
[OnError]: #onerror
