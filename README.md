# BookWorm
BookWorm is a SwiftUI reading companion app that turns reading time into a reward loop. It includes the creation and naming of a worm companion, the running of a reading timer, the earning of rewards called apples, and the spending of the apples on items to personalize the worm and its room(the homepage of the app).

## Features
- Guided setup for choosing and naming a worm
- Start, pause, reset, and end reading sessions with an easy-to-use reading timer
- Apple rewards earned from completed reading time
- Fully customizable room with shelves, decorations, wallpaper, furniture, hats, scarves, etc.
- Store for purchasing items and inventory for placing owned items with reorganization/redecoration functionality
- Library for logging books and rating them
- Local app state for the active session, including timer progress

## Built With
- Swift
- SwiftUI
- Observation (`@Observable`)
- `@AppStorage` for lightweight persisted setup and timer state
- Custom, hand-drawn image assets and Gaegu fonts

## Requirements
- macOS with a current version of Xcode installed
- An iPhone or iPad simulator, or a connected device supported by the project target
- Will soon be available on the Apple app-store

No third-party packages or external services are required.

## Run the App
1. Open `bookWorm.xcodeproj` in Xcode.
2. Select the **bookWorm** scheme.
3. Choose an iOS Simulator or a connected device from the run destination menu.
4. Press **Run** (⌘R).
5. Complete the first-launch setup to begin using the app.

To restart the onboarding flow while developing, remove the app from the simulator or reset the simulator's app data. This clears the `hasCompletedSetUp` value stored by the app.

## Using BookWorm
1. Choose and name a worm during setup, then answer the reading-habit questions.
2. Tap the timer in the room to start, pause, reset, or finish a reading session.
3. When a session ends, BookWorm converts whole minutes read into apples.
4. Open **Store** to buy items with apples.
5. Open the worm profile/inventory to place purchased items in the room.
6. Use the library to keep track of books and their ratings.

## Project Layout

| Path | Purpose |
|---|---|
| `bookWorm/bookWormApp.swift` | App entry point, shared `WormProfile`, and app colors |
| `bookWorm/ScreenNavigator.swift` | Chooses onboarding or the main room |
| `bookWorm/BookWormSetUp.swift` | First-run companion and reading-goal setup |
| `bookWorm/ContentView.swift` | Main room, timer, rewards, store, and profile presentation |
| `bookWorm/Store.swift` and `bookWorm/Catalog.swift` | Store interface and item catalog |
| `bookWorm/PurchasedItems.swift` | Inventory and room-item placement |
| `bookWorm/Library.swift` and `bookWorm/RatingView.swift` | Book library and ratings |
| `bookWorm/Assets.xcassets` | Image assets |
| `bookWorm/Fonts` | Bundled Gaegu font files |

## Notes
BookWorm is currently an all-local app. Its setup and timer state use `@AppStorage`, while the active worm profile, apples, purchases, and room customization are maintained in memory for the running app session.
