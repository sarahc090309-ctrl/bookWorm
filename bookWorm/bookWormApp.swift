//
//  bookWormApp.swift
//  bookWorm
//

import SwiftUI

private struct WormProfileState: Codable {
    var name = "Wormus"
    var selectedWorm: BookWormSetUp.Worm = .basic
    var apples = 0
    var totalTime: TimeInterval = 0
    var readingGoal = 0.0

    var shelfOne = "BasicShelf"
    var shelfTwo = "BasicShelf"
    var shelfThree = "BasicShelf"
    var shelfFour = "BasicShelf"
    var shelfFive = "BasicShelf"
    var shelfSix = "BasicShelf"
    var shelfSeven = "BasicShelf"
    var shelfEight = "BasicShelf"

    var libraryButton = "DefaultLibraryButton"
    var timerButton = "DefaultTimerButton"

    var decorOne = "Placeholder"
    var decorTwo = "Placeholder"
    var decorThree = "Placeholder"
    var decorFour = "Placeholder"
    var decorFive = "Placeholder"
    var decorSix = "Placeholder"
    var decorSeven = "Placeholder"
    var decorEight = "Placeholder"

    var shelfObjectOne = "Placeholder"
    var shelfObjectTwo = "Placeholder"
    var shelfObjectThree = "Placeholder"
    var shelfObjectFour = "Placeholder"
    var shelfObjectFive = "Placeholder"
    var shelfObjectSix = "Placeholder"
    var shelfObjectSeven = "Placeholder"
    var shelfObjectEight = "Placeholder"
    var shelfObjectNine = "Placeholder"
    var shelfObjectTen = "Placeholder"
    var shelfObjectEleven = "Placeholder"
    var shelfObjectTwelve = "Placeholder"
    var shelfObjectThirteen = "Placeholder"

    var hat = "Placeholder"
    var scarf = "Placeholder"
    var wallpaper = "Placeholder"
    var clockNeedStand = false
    var purchasedItems: [Item] = []
}

@MainActor
@Observable
final class WormProfile {
    private static let storageKey = "wormProfile"
    private var state: WormProfileState {
        didSet {
            save()
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let savedState = try? JSONDecoder().decode(WormProfileState.self, from: data) {
            state = savedState
        } else {
            state = WormProfileState()
        }
    }

    var name: String { get { state.name } set { state.name = newValue } }
    var selectedWorm: BookWormSetUp.Worm { get { state.selectedWorm } set { state.selectedWorm = newValue } }
    var apples: Int { get { state.apples } set { state.apples = newValue } }
    var totalTime: TimeInterval { get { state.totalTime } set { state.totalTime = newValue } }
    var readingGoal: Double { get { state.readingGoal } set { state.readingGoal = newValue } }

    var shelfOne: String { get { state.shelfOne } set { state.shelfOne = newValue } }
    var shelfTwo: String { get { state.shelfTwo } set { state.shelfTwo = newValue } }
    var shelfThree: String { get { state.shelfThree } set { state.shelfThree = newValue } }
    var shelfFour: String { get { state.shelfFour } set { state.shelfFour = newValue } }
    var shelfFive: String { get { state.shelfFive } set { state.shelfFive = newValue } }
    var shelfSix: String { get { state.shelfSix } set { state.shelfSix = newValue } }
    var shelfSeven: String { get { state.shelfSeven } set { state.shelfSeven = newValue } }
    var shelfEight: String { get { state.shelfEight } set { state.shelfEight = newValue } }

    var libraryButton: String { get { state.libraryButton } set { state.libraryButton = newValue } }
    var timerButton: String { get { state.timerButton } set { state.timerButton = newValue } }

    var decorOne: String { get { state.decorOne } set { state.decorOne = newValue } }
    var decorTwo: String { get { state.decorTwo } set { state.decorTwo = newValue } }
    var decorThree: String { get { state.decorThree } set { state.decorThree = newValue } }
    var decorFour: String { get { state.decorFour } set { state.decorFour = newValue } }
    var decorFive: String { get { state.decorFive } set { state.decorFive = newValue } }
    var decorSix: String { get { state.decorSix } set { state.decorSix = newValue } }
    var decorSeven: String { get { state.decorSeven } set { state.decorSeven = newValue } }
    var decorEight: String { get { state.decorEight } set { state.decorEight = newValue } }

    var shelfObjectOne: String { get { state.shelfObjectOne } set { state.shelfObjectOne = newValue } }
    var shelfObjectTwo: String { get { state.shelfObjectTwo } set { state.shelfObjectTwo = newValue } }
    var shelfObjectThree: String { get { state.shelfObjectThree } set { state.shelfObjectThree = newValue } }
    var shelfObjectFour: String { get { state.shelfObjectFour } set { state.shelfObjectFour = newValue } }
    var shelfObjectFive: String { get { state.shelfObjectFive } set { state.shelfObjectFive = newValue } }
    var shelfObjectSix: String { get { state.shelfObjectSix } set { state.shelfObjectSix = newValue } }
    var shelfObjectSeven: String { get { state.shelfObjectSeven } set { state.shelfObjectSeven = newValue } }
    var shelfObjectEight: String { get { state.shelfObjectEight } set { state.shelfObjectEight = newValue } }
    var shelfObjectNine: String { get { state.shelfObjectNine } set { state.shelfObjectNine = newValue } }
    var shelfObjectTen: String { get { state.shelfObjectTen } set { state.shelfObjectTen = newValue } }
    var shelfObjectEleven: String { get { state.shelfObjectEleven } set { state.shelfObjectEleven = newValue } }
    var shelfObjectTwelve: String { get { state.shelfObjectTwelve } set { state.shelfObjectTwelve = newValue } }
    var shelfObjectThirteen: String { get { state.shelfObjectThirteen } set { state.shelfObjectThirteen = newValue } }

    var hat: String { get { state.hat } set { state.hat = newValue } }
    var scarf: String { get { state.scarf } set { state.scarf = newValue } }
    var wallpaper: String { get { state.wallpaper } set { state.wallpaper = newValue } }
    var clockNeedStand: Bool { get { state.clockNeedStand } set { state.clockNeedStand = newValue } }
    var purchasedItems: [Item] { get { state.purchasedItems } set { state.purchasedItems = newValue } }

    private func save() {
        guard let data = try? JSONEncoder().encode(state) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }
}

extension Color {
    static let background = Color(red: 247/255, green: 243/255, blue: 227/255)
    static let textColor = Color(red: 81/255, green: 46/255, blue: 29/255)
    static let pink = Color(red: 253/255, green: 150/255, blue: 169/255)
    static let yellow = Color(red: 242/255, green: 200/255, blue: 104/255)
    static let green = Color(red: 83/255, green: 161/255, blue: 105/255)
    static let blue = Color(red: 125/255, green: 195/255, blue: 251/255)
}

@main
struct bookWormApp: App {
    @State private var wormProfile = WormProfile()

    var body: some Scene {
        WindowGroup {
            ScreenNavigator()
                .environment(wormProfile)
        }
    }
}
