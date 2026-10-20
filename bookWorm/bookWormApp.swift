//
//  bookWormApp.swift
//  bookWorm
//
//  Created by Sarah Chang on 6/9/26.
//

import SwiftUI



@Observable class WormProfile {
    var name: String = "Wormus"
    var selectedWorm: BookWormSetUp.Worm = .basic
    
    var apples: Int = 0
    var totalTime: TimeInterval = 0
    var readingGoal: Double = 0.0
    
    var shelfOne: String = "BasicShelf"
    var shelfTwo: String = "BasicShelf"
    var shelfThree: String = "BasicShelf"
    var shelfFour: String = "BasicShelf"
    var shelfFive: String = "BasicShelf"
    var shelfSix: String = "BasicShelf"
    var shelfSeven: String = "BasicShelf"
    var shelfEight: String = "BasicShelf"
    
    var libraryButton: String = "DefaultLibraryButton"
    var timerButton: String = "DefaultTimerButton"
    
    var decorOne: String = "Placeholder"
    var decorTwo: String = "Placeholder"
    var decorThree: String = "Placeholder"
    var decorFour: String = "Placeholder"
    var decorFive: String = "Placeholder"
    var decorSix: String = "Placeholder"
    var decorSeven: String = "Placeholder"
    var decorEight: String = "Placeholder"
    
    var shelfObjectOne: String = "Placeholder"
    var shelfObjectTwo: String = "Placeholder"
    var shelfObjectThree: String = "Placeholder"
    var shelfObjectFour: String = "Placeholder"
    var shelfObjectFive: String = "Placeholder"
    var shelfObjectSix: String = "Placeholder"
    var shelfObjectSeven: String = "Placeholder"
    var shelfObjectEight: String = "Placeholder"
    var shelfObjectNine: String = "Placeholder"
    var shelfObjectTen: String = "Placeholder"
    var shelfObjectEleven: String = "Placeholder"
    var shelfObjectTwelve: String = "Placeholder"
    var shelfObjectThirteen: String = "Placeholder"
    
    var hat: String = "Placeholder"
    var scarf: String = "Placeholder"
    
    var wallpaper: String = "Placeholder"
    
    var clockNeedStand: Bool = false
    
    var purchasedItems: [Item] = []
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
