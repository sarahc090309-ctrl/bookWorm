//
//  Catalog.swift
//  bookWorm
//
//  Created by Sarah Chang on 8/3/26.
//

import SwiftUI

enum ItemType: Codable {
    case clock, shelf, library, shelfObj, decor, wallpaper, hat, scarf
}

enum Location: Codable, Equatable {
    case clock, library, wallpaper, hat, scarf
    case shelfOne, shelfTwo, shelfThree, shelfFour, shelfFive, shelfSix, shelfSeven, shelfEight
    case decorOne, decorTwo, decorThree, decorFour, decorFive, decorSix, decorSeven, decorEight
    case shelfObjOne, shelfObjTwo, shelfObjThree, shelfObjFour, shelfObjFive, shelfObjSix, shelfObjSeven, shelfObjEight, shelfObjNine, shelfObjTen, shelfObjEleven, shelfObjTwelve, shelfObjThirteen
}

struct Item: Identifiable, Codable {
    
    let id: UUID
    
    let name: String
    let price: Int
    let needsStand: Bool
    let type: ItemType
    var location: Location?
    
    init(id: UUID = UUID(), name: String, price: Int, needsStand: Bool, type: ItemType, location: Location? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.needsStand = needsStand
        self.type = type
        self.location = location
    }
}


struct Catalog {
    let catalog: [[Item]] = [
        [
        Item(name: "OrangeClockIcon", price: 75, needsStand: false, type: .clock),
        Item(name: "LemonClockIcon", price: 75, needsStand: false, type: .clock),
        Item(name: "LimeClockIcon", price: 75, needsStand: false, type: .clock),
        Item(name: "StrawberryClockIcon", price: 125, needsStand: false, type: .clock),
        Item(name: "AlarmClockIcon", price: 125, needsStand: true, type: .clock),
        Item(name: "RetroClockIcon", price: 125, needsStand: true, type: .clock),
        Item(name: "FishClockIcon", price: 275, needsStand: false, type: .clock),
        Item(name: "SunClockIcon", price: 275, needsStand: false, type: .clock),
        Item(name: "CatClockIcon", price: 350, needsStand: false, type: .clock),
        Item(name: "GrandfatherClockIcon", price: 500, needsStand: false, type: .clock),
        Item(name: "DaliClockIcon", price: 500, needsStand: false, type: .clock),
        Item(name: "HourGlassIcon", price: 500, needsStand: true, type: .clock),
        ],
        [
        Item(name: "StripedShelf", price: 100, needsStand: false, type: .shelf),
        Item(name: "CheckeredShelf", price: 100, needsStand: false, type: .shelf),
        Item(name: "CurvedShelf", price: 150, needsStand: false, type: .shelf),
        Item(name: "RainbowShelf", price: 150, needsStand: false, type: .shelf),
        Item(name: "DrippyShelf", price: 150, needsStand: false, type: .shelf),
        Item(name: "BubbleShelf", price: 250, needsStand: false, type: .shelf),
        Item(name: "CloudShelf", price: 250, needsStand: false, type: .shelf),
        Item(name: "VineShelf", price: 500, needsStand: false, type: .shelf),
        Item(name: "HeartShelf", price: 750, needsStand: false, type: .shelf),
        ],
        [
        Item(name: "PlantLibraryIcon", price: 150, needsStand: false, type: .library),
        Item(name: "MugLibraryIcon", price: 150, needsStand: false, type: .library),
        Item(name: "FiligreeLibraryIcon", price: 250, needsStand: false, type: .library),
        Item(name: "VineLibraryIcon", price: 250, needsStand: false, type: .library),
        Item(name: "CastleLibraryIcon", price: 500, needsStand: false, type: .library),
        Item(name: "BunnyLibraryIcon", price: 750, needsStand: false, type: .library),
        Item(name: "FloralLibraryIcon", price: 750, needsStand: false, type: .library)
        ],
        [
        Item(name: "LeafyPottedPlant", price: 50, needsStand: false, type: .shelfObj),
        Item(name: "Succulents", price: 50, needsStand: false, type: .shelfObj),
        Item(name: "YellowPotPlant", price: 75, needsStand: false, type: .shelfObj),
        Item(name: "BlueFlower", price: 75, needsStand: false, type: .shelfObj),
        Item(name: "BoringLamp", price: 75, needsStand: false, type: .shelfObj),
        Item(name: "TrapezoidLamp", price: 75, needsStand: false, type: .shelfObj),
        Item(name: "FlowerPlants", price: 100, needsStand: false, type: .shelfObj),
        Item(name: "SingleCactusPlant", price: 100, needsStand: false, type: .shelfObj),
        Item(name: "SnakePlant", price: 150, needsStand: false, type: .shelfObj),
        Item(name: "MushroomLamp", price: 150, needsStand: false, type: .shelfObj),
        Item(name: "StreetLamp", price: 150, needsStand: false, type: .shelfObj),
        Item(name: "TeapotPot", price: 300, needsStand: false, type: .shelfObj),
        Item(name: "VinesLamp", price: 300, needsStand: false, type: .shelfObj),
        Item(name: "VinePlant", price: 500, needsStand: false, type: .shelfObj),
        Item(name: "LavaLamps", price: 500, needsStand: false, type: .shelfObj),
        Item(name: "BearPotPlant", price: 750, needsStand: false, type: .shelfObj),
        Item(name: "BonsaiPlant", price: 750, needsStand: false, type: .shelfObj),
        Item(name: "LilyOfTheValleyLamp", price: 750, needsStand: false, type: .shelfObj),
        Item(name: "StainedGlassLamp", price: 750, needsStand: false, type: .shelfObj)
        ],
        [
        Item(name: "MoonPoster", price: 50, needsStand: false, type: .decor),
        Item(name: "MusicNotes", price: 50, needsStand: false, type: .decor),
        Item(name: "WhiteRosePoster", price: 75, needsStand: false, type: .decor),
        Item(name: "CloudPoster", price: 75, needsStand: false, type: .decor),
        Item(name: "RedRecord", price: 100, needsStand: false, type: .decor),
        Item(name: "GreenRecord", price: 100, needsStand: false, type: .decor),
        Item(name: "YellowRecord", price: 100, needsStand: false, type: .decor),
        Item(name: "ButtonWallDecor", price: 100, needsStand: false, type: .decor),
        Item(name: "HangingStars", price: 100, needsStand: false, type: .decor),
        Item(name: "PinkCat", price: 125, needsStand: false, type: .decor),
        Item(name: "WisteriaPoster", price: 125, needsStand: false, type: .decor),
        Item(name: "SunPoster", price: 125, needsStand: false, type: .decor),
        Item(name: "SmallNaturalistPosters", price: 200, needsStand: false, type: .decor),
        Item(name: "MushroomEmbroidery", price: 200, needsStand: false, type: .decor)
        ],
        [
        Item(name: "YellowStripeWallpaper", price: 1000, needsStand: false, type: .wallpaper),
        Item(name: "GinghamWallpaper", price: 1000, needsStand: false, type: .wallpaper),
        Item(name: "CoquetteWallpaper", price: 2000, needsStand: false, type: .wallpaper),
        Item(name: "FlowerWallpaper", price: 2000, needsStand: false, type: .wallpaper),
        Item(name: "WatermelonWallpaper", price: 2000, needsStand: false, type: .wallpaper),
        Item(name: "BrownRoseWallpaper", price: 2000, needsStand: false, type: .wallpaper),
        Item(name: "QuiltWallpaper", price: 3000, needsStand: false, type: .wallpaper),
        Item(name: "MandelaWallpaper", price: 3000, needsStand: false, type: .wallpaper),
        ],
        [
        Item(name: "PinkStripeBeanie", price: 50, needsStand: false, type: .hat),
        Item(name: "BaseballHat", price: 50, needsStand: false, type: .hat),
        Item(name: "Headphones", price: 100, needsStand: false, type: .hat),
        Item(name: "FrogBucketHat", price: 150, needsStand: false, type: .hat),
        Item(name: "PropellerHat", price: 150, needsStand: false, type: .hat),
        Item(name: "WitchHat", price: 300, needsStand: false, type: .hat),
        Item(name: "CowboyHat", price: 300, needsStand: false, type: .hat),
        ],
        [
        Item(name: "PurpleScarf", price: 25, needsStand: false, type: .scarf),
        Item(name: "BlackTie", price: 25, needsStand: false, type: .scarf),
        Item(name: "GryffindorScarf", price: 50, needsStand: false, type: .scarf),
        Item(name: "SlytherinScarf", price: 50, needsStand: false, type: .scarf),
        Item(name: "RavenclawScarf", price: 50, needsStand: false, type: .scarf),
        Item(name: "HufflepuffScarf", price: 50, needsStand: false, type: .scarf),
        Item(name: "QuiltScarf", price: 100, needsStand: false, type: .scarf),
        Item(name: "RainbowScarf", price: 100, needsStand: false, type: .scarf),
        ]
    ]
}
