# bookWorm
An iOS app for encouraging reading, tracking reading time, and logging books written in SwiftUI

- **Framework:** SwiftUI (iOS 17+)
- **Architecture:** Contemporary MVVM layout utilizing Apple's modern native `@Observable` framework.
- **State & Persistence:** 
  - `@Environment` & `@Bindable` for global runtime state management (`WormProfile`).
  - `@AppStorage` for lightweight data persistence (tracking timer state and elapsed reading intervals across sessions).
- **Asynchronous Operations:** `Combine` (`AnyCancellable`) integrated with standard system `Timer` loops.
- **System Services:** `UserNotifications` for handling local time-based alerts.
