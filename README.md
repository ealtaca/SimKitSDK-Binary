# SimKit SDK

Network monitoring, throttling, and mocking SDK for iOS apps.

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/ealtaca/SimKitSDK-Binary.git", from: "1.0.10")
]
```

Or in Xcode:
1. File > Add Package Dependencies
2. Enter: `https://github.com/ealtaca/SimKitSDK-Binary`
3. Select version and add to your target

## Configuration

### Info.plist Setup (Required)

SimKit requires local networking to communicate with the macOS companion app. Add the following to your app's `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>
```

**Note:** Without this configuration, SimKit will show a warning at startup and may not function properly.

## Usage

```swift
import SimKit

// In your AppDelegate or App init
#if DEBUG
SimKitSDK.shared.enable()
#endif
```

### SwiftUI Example

```swift
import SwiftUI
import SimKit

@main
struct MyApp: App {
    init() {
        #if DEBUG
        SimKitSDK.shared.enable()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### UIKit Example

```swift
import UIKit
import SimKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        SimKitSDK.shared.enable()
        #endif
        return true
    }
}
```

## Features

- Network request logging
- Network throttling
- Mock responses
- Performance monitoring
- Main thread block detection
- Memory leak detection

## Requirements

- iOS 13.0+
- macOS 10.15+
- Swift 5.9+

## License

Proprietary. All rights reserved.
