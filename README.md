# SimKit SDK

[![Download on the Mac App Store](https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-mac-app-store.svg)](https://apps.apple.com/en/app/simkit-simulator-toolkit/id6756196371?mt=12)

The companion iOS SDK for [SimKit — Simulator Toolkit](https://apps.apple.com/en/app/simkit-simulator-toolkit/id6756196371?mt=12) — a professional iOS Simulator toolkit for macOS. Add one line of code to unlock real-time network monitoring, throttling, mocking, WebSocket inspection, and performance insights directly from the SimKit macOS app.

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ealtaca/SimKitSDK-Binary.git", from: "1.8.0")
]
```

Or in Xcode:

1. **File > Add Package Dependencies**
2. Enter: `https://github.com/ealtaca/SimKitSDK-Binary`
3. Select version **1.8.0** or later
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

## Features

### Network Monitoring
All HTTP/HTTPS requests are automatically intercepted and displayed in the SimKit macOS app in real time. Inspect request/response headers, bodies, timing, and status codes — plus the phase breakdown (DNS, connect, TLS, TTFB, download), redirect chains hop by hop, TLS certificate expiry and issuer, and Server-Sent Event streams.

### Network Throttling
Simulate real-world network conditions (3G, LTE, WiFi, offline) directly from the macOS app. Throttling is applied transparently — no code changes needed.

Since 1.8.0 it reaches `WKWebView` navigations as well: Offline blocks them and latency delays their start, so a web view no longer loads at full speed while the rest of your app is throttled. Only those two apply there — WebKit owns the byte stream, so bandwidth shaping and subresource-level throttling are not possible inside a web view.

### Mock Responses
Define mock endpoints in the SimKit macOS app. Matching requests are intercepted and return your custom responses. Match on URL, method, query, headers or body; template your responses; step through a sequence of responses to drive stateful flows; and inject faults (timeouts, connection failures, malformed payloads) to exercise your error paths. Supports large response bodies via local HTTP server.

### WebSocket Inspection
Monitor WebSocket connections, messages, and frames. Inject mock WebSocket messages from the macOS app for testing real-time features.

**Supported transports:**
- **URLSessionWebSocketTask** — automatically intercepted, no configuration needed
- **Socket.IO (SocketIO/socket.io-client-swift)** — automatically detected and intercepted at runtime. Connection lifecycle, incoming/outgoing messages, and disconnect events are all captured. Works with both default and custom engine configurations.

### WKWebView Navigations
`WKWebView` loads through WebKit's own networking process, which no `URLProtocol` can
reach — so web view traffic used to be invisible. SimKit captures navigations directly:
main frame and iframes, link taps, JavaScript and server redirects, status codes,
durations and failures, shown as ordinary rows in the Network tab.

**Cookies** *(new in 1.8.0)* — WebKit strips `Cookie` and `Set-Cookie` before a
navigation delegate ever sees them, so a header-based cookie view has nothing to show.
SimKit reads the web view's own cookie store as each navigation starts and reports the
cookies that applied to it, with domain, path, expiry, `Secure`, `HttpOnly` and
`SameSite` intact. Values are captured verbatim — session tokens included — and sent to
the macOS app like any other request detail. Viewing them needs a matching macOS app
version.

This is a navigation-level view by design. Subresources (images, CSS, JS), `XHR`/`fetch`
calls made from page script, and response bodies are not included.

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

**Web view traffic looks incomplete**
`WKWebView` navigations are captured, but the resources a page loads (images, CSS, JS)
and its `XHR`/`fetch` calls are not — WebKit routes those through its own networking
process, out of reach of `URLProtocol`.

**Third-party networking libraries**
SimKit intercepts HTTP requests at the `URLProtocol` level. Libraries that use `URLSession` (Alamofire, Moya, etc.) are automatically supported. For WebSockets, `URLSessionWebSocketTask` and Socket.IO (`socket.io-client-swift`) are automatically intercepted. Libraries using custom `NWConnection`-based WebSocket transports (e.g. Starscream with `useCustomEngine: true`) may not be fully captured.

## Feedback

Found a bug or have a feature request? [Open an issue](https://github.com/ealtaca/SimKitSDK-Binary/issues) — we'd love to hear from you.

## License

Proprietary. All rights reserved.
