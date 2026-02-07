# SimKit SDK

The companion iOS SDK for [SimKit — Simulator Toolkit](https://apps.apple.com/en/app/simkit-simulator-toolkit/id6756196371?mt=12) — a professional iOS Simulator toolkit for macOS. Add one line of code to unlock real-time network monitoring, throttling, mocking, WebSocket inspection, and performance insights directly from the SimKit macOS app.

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ealtaca/SimKitSDK-Binary.git", from: "1.1.0")
]
```

Or in Xcode:

1. **File > Add Package Dependencies**
2. Enter: `https://github.com/ealtaca/SimKitSDK-Binary`
3. Select version **1.1.0** or later
4. Add `SimKit` to your target

## Setup

### 1. Info.plist (Required)

SimKit uses local networking to communicate with the macOS companion app. Add the following to your app's `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>
```

> Without this, SimKit will log a warning at startup and network interception will not work.

### 2. Enable the SDK

```swift
import SimKit

#if DEBUG
SimKitSDK.shared.enable()
#endif
```

> Always wrap in `#if DEBUG` — SimKit is a development tool and should not ship in production builds.

### SwiftUI

```swift
import SwiftUI
import SimKit

@main
struct MyApp: App {
    init() {
        // Your other setup code...

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

### UIKit

```swift
import UIKit
import SimKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Your other setup code...

        #if DEBUG
        SimKitSDK.shared.enable()
        #endif
        return true
    }
}
```

## Configuration

Customize SDK behavior before calling `enable()`:

```swift
#if DEBUG
let sdk = SimKitSDK.shared

// WebSocket interception (default: true)
sdk.config.webSocketInterceptionEnabled = true

// Performance monitoring (default: false, controlled via macOS app)
sdk.config.performanceMonitoringEnabled = false

// Main thread block threshold (default: 200ms)
sdk.config.mainThreadBlockThresholdMs = 200

// Memory leak detection (default: true)
sdk.config.memoryLeakDetectionEnabled = true

// Launch time profiling (default: true)
sdk.config.launchTimeProfilingEnabled = true

sdk.enable()
#endif
```

## Features

### Network Monitoring
All HTTP/HTTPS requests are automatically intercepted and displayed in the SimKit macOS app in real time. Inspect request/response headers, bodies, timing, and status codes.

### Network Throttling
Simulate real-world network conditions (3G, LTE, WiFi, offline) directly from the macOS app. Throttling is applied transparently — no code changes needed.

### Mock Responses
Define mock endpoints in the SimKit macOS app. Matching requests are intercepted and return your custom responses. Supports large response bodies via local HTTP server.

### WebSocket Inspection
Monitor WebSocket connections, messages, and frames. Inject mock WebSocket messages from the macOS app for testing real-time features.

### Performance Monitoring
When enabled from the macOS app's Insights tab:
- **Main thread block detection** — flags UI freezes above the configured threshold
- **Memory leak detection** — identifies potential retain cycles
- **Launch time profiling** — measures pre-main, post-main, and total launch time
- **Memory usage tracking** — monitors real-time memory consumption

## How It Works

SimKit SDK communicates with the SimKit macOS app over a local WebSocket connection. The macOS app automatically detects running simulators and pairs with them — no manual configuration needed. Just run your app in the simulator with the SimKit macOS app open.

## Requirements

| Requirement | Minimum |
|-------------|---------|
| iOS | 13.0+ |
| macOS | 10.15+ |
| Swift | 5.9+ |
| Xcode | 15.0+ |

## Troubleshooting

**SDK logs "ATS configuration warning"**
Add `NSAllowsLocalNetworking` to your Info.plist (see Setup step 1).

**No requests showing in SimKit macOS app**
- Make sure the SimKit macOS app is running
- Verify the simulator is detected in the SimKit floating panel
- Check that the SDK is enabled (`SimKitSDK.shared.enable()`)

**Third-party networking libraries**
SimKit intercepts requests at the `URLProtocol` level. Libraries that use `URLSession` (Alamofire, Moya, etc.) are automatically supported. Libraries with custom networking stacks may require additional configuration.

## Feedback

Found a bug or have a feature request? [Open an issue](https://github.com/ealtaca/SimKitSDK-Binary/issues) — we'd love to hear from you.

## License

Proprietary. All rights reserved.
