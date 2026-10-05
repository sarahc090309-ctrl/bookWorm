//
//  PurchasedItems.swift
//  bookWorm
//
//  Created by Sarah Chang on 8/14/26.
//

import SwiftUI

struct PurchasedItems: View {
    
    @Environment(WormProfile.self) private var wormProfile
    
    @State private var selectedItem = Catalog().catalog[0][0]
    @State private var isShowingPlacementView = false
    @State private var selectedPreviewLocation: Location?
    
    private let catalogItemNames = Set(Catalog().catalog.flatMap { $0.map(\.name) })
    
    private let columns = [
        GridItem(.fixed(115), spacing: 10),
        GridItem(.fixed(115), spacing: 10)
    ]
    
    var body: some View{
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.background)
                .frame(width: 342, height: 705)
                .padding(.top, 35)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 300, height: 655)
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.blue, lineWidth: 2))
                .padding(.top, 35)
            ScrollView{
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(wormProfile.purchasedItems) { purchasedItem in
                        if purchasedItem.type == .shelf {
                            shelfButton(purchasedItem)
                        }
                        else {
                            itemButton(purchasedItem)
                        }
                    }
                }
                .padding(.top, 35)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .frame(width: 300, height: 650)
            .padding(.top, 35)
        }
        .overlay {
            if isShowingPlacementView {
                placementView
                    .transition(.opacity.combined(with: .scale(scale: 0.96)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isShowingPlacementView)
    }
    
    private var placementView: some View {
        ZStack {
            Color.background
                .frame(width: 342, height: 700)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(spacing: 12) {
                Color.background
                    .frame(width: 300, height: 620)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        MiniContentPreview(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPlacementView, selectedPreviewLocation: $selectedPreviewLocation, clearsExistingSelectedItem: true)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.blue, lineWidth: 2))
                
                HStack(spacing: 12) {
                    Button {
                        placeSelectedItem()
                    } label: {
                        Text("Confirm")
                            .font(.custom("Gaegu-Bold", size: 24))
                            .foregroundStyle(Color.background)
                            .frame(width: 120, height: 44)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button {
                        isShowingPlacementView = false
                    } label: {
                        Text("Cancel")
                            .font(.custom("Gaegu-Bold", size: 24))
                            .foregroundStyle(Color.textColor)
                            .frame(width: 120, height: 44)
                            .background(Color.background)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.blue, lineWidth: 2))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    private func itemButton(_ itemButton: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = itemButton
                selectedPreviewLocation = itemButton.location ?? defaultSelectedLocation(for: itemButton)
                isShowingPlacementView = true
            } label: {
                Image(itemButton.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(10)
                    .background(Color.background)
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
        }
    }
    
    private func shelfButton(_ shelfButton: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = shelfButton
                selectedPreviewLocation = shelfButton.location
                isShowingPlacementView = true
            } label: {
                Image("\(shelfButton.name)Medium")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(10)
                    .background(Color.background)
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
        }
    }
    
    func locationIsAvailable(_ place: Location) -> Bool {
        return true
    }
    
    private func placeSelectedItem() {
        guard let selectedPreviewLocation else {
            clearSelectedItemLocation()
            isShowingPlacementView = false
            return
        }
        
        guard locationIsAvailable(selectedPreviewLocation) else { return }
        
        if let currentLocation = selectedItem.location, currentLocation != selectedPreviewLocation {
            clearLocation(currentLocation)
        }
        
        clearPurchasedItemLocation(at: selectedPreviewLocation)
        updateWormProfile(for: selectedItem, at: selectedPreviewLocation)
        updateSelectedPurchasedItemLocation(to: selectedPreviewLocation)
        isShowingPlacementView = false
    }
    
    private func updateSelectedPurchasedItemLocation(to location: Location) {
        guard let selectedIndex = wormProfile.purchasedItems.firstIndex(where: { $0.id == selectedItem.id }) else { return }
        
        wormProfile.purchasedItems[selectedIndex].location = location
        selectedItem.location = location
    }
    
    private func clearSelectedItemLocation() {
        guard let currentLocation = selectedItem.location,
              let selectedIndex = wormProfile.purchasedItems.firstIndex(where: { $0.id == selectedItem.id }) else { return }
        
        clearLocation(currentLocation)
        wormProfile.purchasedItems[selectedIndex].location = nil
        selectedItem.location = nil
    }
    
    private func clearPurchasedItemLocation(at location: Location) {
        guard let occupyingItemIndex = wormProfile.purchasedItems.firstIndex(where: { $0.id != selectedItem.id && $0.location == location }) else { return }
        
        wormProfile.purchasedItems[occupyingItemIndex].location = nil
    }
    
    private func clearLocation(_ location: Location) {
        updateWormProfileImage(at: location, to: defaultImageName(for: location), clockNeedsStand: false)
    }
    
    private func updateWormProfile(for item: Item, at location: Location) {
        guard locationMatchesItemType(location, item) else { return }
        updateWormProfileImage(at: location, to: item.name, clockNeedsStand: item.needsStand)
    }
    
    private func updateWormProfileImage(at location: Location, to imageName: String, clockNeedsStand: Bool) {
        
        switch location {
        case .clock:
            wormProfile.timerButton = imageName
            wormProfile.clockNeedStand = clockNeedsStand
        case .library:
            wormProfile.libraryButton = imageName
        case .wallpaper:
            wormProfile.wallpaper = imageName
        case .hat:
            wormProfile.hat = imageName
        case .scarf:
            wormProfile.scarf = imageName
        case .shelfOne:
            wormProfile.shelfOne = imageName
        case .shelfTwo:
            wormProfile.shelfTwo = imageName
        case .shelfThree:
            wormProfile.shelfThree = imageName
        case .shelfFour:
            wormProfile.shelfFour = imageName
        case .shelfFive:
            wormProfile.shelfFive = imageName
        case .shelfSix:
            wormProfile.shelfSix = imageName
        case .shelfSeven:
            wormProfile.shelfSeven = imageName
        case .shelfEight:
            wormProfile.shelfEight = imageName
        case .shelfObjOne:
            wormProfile.shelfObjectOne = imageName
        case .shelfObjTwo:
            wormProfile.shelfObjectTwo = imageName
        case .shelfObjThree:
            wormProfile.shelfObjectThree = imageName
        case .shelfObjFour:
            wormProfile.shelfObjectFour = imageName
        case .shelfObjFive:
            wormProfile.shelfObjectFive = imageName
        case .shelfObjSix:
            wormProfile.shelfObjectSix = imageName
        case .shelfObjSeven:
            wormProfile.shelfObjectSeven = imageName
        case .shelfObjEight:
            wormProfile.shelfObjectEight = imageName
        case .shelfObjNine:
            wormProfile.shelfObjectNine = imageName
        case .shelfObjTen:
            wormProfile.shelfObjectTen = imageName
        case .shelfObjEleven:
            wormProfile.shelfObjectEleven = imageName
        case .shelfObjTwelve:
            wormProfile.shelfObjectTwelve = imageName
        case .shelfObjThirteen:
            wormProfile.shelfObjectThirteen = imageName
        case .decorOne:
            wormProfile.decorOne = imageName
        case .decorTwo:
            wormProfile.decorTwo = imageName
        case .decorThree:
            wormProfile.decorThree = imageName
        case .decorFour:
            wormProfile.decorFour = imageName
        case .decorFive:
            wormProfile.decorFive = imageName
        case .decorSix:
            wormProfile.decorSix = imageName
        case .decorSeven:
            wormProfile.decorSeven = imageName
        case .decorEight:
            wormProfile.decorEight = imageName
        }
    }
    
    private func clearShelfLocations(named itemName: String) {
        if wormProfile.shelfOne == itemName { wormProfile.shelfOne = "BasicShelf" }
        if wormProfile.shelfTwo == itemName { wormProfile.shelfTwo = "BasicShelf" }
        if wormProfile.shelfThree == itemName { wormProfile.shelfThree = "BasicShelf" }
        if wormProfile.shelfFour == itemName { wormProfile.shelfFour = "BasicShelf" }
        if wormProfile.shelfFive == itemName { wormProfile.shelfFive = "BasicShelf" }
        if wormProfile.shelfSix == itemName { wormProfile.shelfSix = "BasicShelf" }
        if wormProfile.shelfSeven == itemName { wormProfile.shelfSeven = "BasicShelf" }
        if wormProfile.shelfEight == itemName { wormProfile.shelfEight = "BasicShelf" }
    }
    
    private func clearShelfObjectLocations(named itemName: String) {
        if wormProfile.shelfObjectOne == itemName { wormProfile.shelfObjectOne = "Placeholder" }
        if wormProfile.shelfObjectTwo == itemName { wormProfile.shelfObjectTwo = "Placeholder" }
        if wormProfile.shelfObjectThree == itemName { wormProfile.shelfObjectThree = "Placeholder" }
        if wormProfile.shelfObjectFour == itemName { wormProfile.shelfObjectFour = "Placeholder" }
        if wormProfile.shelfObjectFive == itemName { wormProfile.shelfObjectFive = "Placeholder" }
        if wormProfile.shelfObjectSix == itemName { wormProfile.shelfObjectSix = "Placeholder" }
        if wormProfile.shelfObjectSeven == itemName { wormProfile.shelfObjectSeven = "Placeholder" }
        if wormProfile.shelfObjectEight == itemName { wormProfile.shelfObjectEight = "Placeholder" }
        if wormProfile.shelfObjectNine == itemName { wormProfile.shelfObjectNine = "Placeholder" }
        if wormProfile.shelfObjectTen == itemName { wormProfile.shelfObjectTen = "Placeholder" }
        if wormProfile.shelfObjectEleven == itemName { wormProfile.shelfObjectEleven = "Placeholder" }
        if wormProfile.shelfObjectTwelve == itemName { wormProfile.shelfObjectTwelve = "Placeholder" }
        if wormProfile.shelfObjectThirteen == itemName { wormProfile.shelfObjectThirteen = "Placeholder" }
    }
    
    private func clearDecorLocations(named itemName: String) {
        if wormProfile.decorOne == itemName { wormProfile.decorOne = "Placeholder" }
        if wormProfile.decorTwo == itemName { wormProfile.decorTwo = "Placeholder" }
        if wormProfile.decorThree == itemName { wormProfile.decorThree = "Placeholder" }
        if wormProfile.decorFour == itemName { wormProfile.decorFour = "Placeholder" }
        if wormProfile.decorFive == itemName { wormProfile.decorFive = "Placeholder" }
        if wormProfile.decorSix == itemName { wormProfile.decorSix = "Placeholder" }
        if wormProfile.decorSeven == itemName { wormProfile.decorSeven = "Placeholder" }
        if wormProfile.decorEight == itemName { wormProfile.decorEight = "Placeholder" }
    }
    
    private func defaultImageName(for location: Location) -> String {
        switch location {
        case .clock:
            return "DefaultTimerButton"
        case .library:
            return "DefaultLibraryButton"
        case .shelfOne, .shelfTwo, .shelfThree, .shelfFour, .shelfFive, .shelfSix, .shelfSeven, .shelfEight:
            return "BasicShelf"
        case .wallpaper, .hat, .scarf, .decorOne, .decorTwo, .decorThree, .decorFour, .decorFive, .decorSix, .decorSeven, .decorEight, .shelfObjOne, .shelfObjTwo, .shelfObjThree, .shelfObjFour, .shelfObjFive, .shelfObjSix, .shelfObjSeven, .shelfObjEight, .shelfObjNine, .shelfObjTen, .shelfObjEleven, .shelfObjTwelve, .shelfObjThirteen:
            return "Placeholder"
        }
    }
    
    private func defaultPreviewLocation(for item: Item) -> Location {
        switch item.type {
        case .clock:
            return .clock
        case .shelf:
            return .shelfOne
        case .library:
            return .library
        case .shelfObj:
            return .shelfObjOne
        case .decor:
            return .decorOne
        case .wallpaper:
            return .wallpaper
        case .hat:
            return .hat
        case .scarf:
            return .scarf
        }
    }
    
    private func defaultSelectedLocation(for item: Item) -> Location? {
        switch item.type {
        case .hat, .scarf:
            return defaultPreviewLocation(for: item)
        case .clock, .shelf, .library, .shelfObj, .decor, .wallpaper:
            return nil
        }
    }
    
    private func locationMatchesItemType(_ location: Location, _ item: Item) -> Bool {
        switch item.type {
        case .clock:
            return location == .clock
        case .library:
            return location == .library
        case .shelf:
            return shelfLocations.contains(location)
        case .shelfObj:
            return shelfObjLocations.contains(location)
        case .decor:
            return decorLocations.contains(location)
        case .wallpaper:
            return location == .wallpaper
        case .hat:
            return location == .hat
        case .scarf:
            return location == .scarf
        }
    }
    
    private var shelfLocations: [Location] {
        [.shelfOne, .shelfTwo, .shelfThree, .shelfFour, .shelfFive, .shelfSix, .shelfSeven, .shelfEight]
    }
    
    private var shelfObjLocations: [Location] {
        [.shelfObjOne, .shelfObjTwo, .shelfObjThree, .shelfObjFour, .shelfObjFive, .shelfObjSix, .shelfObjSeven, .shelfObjEight, .shelfObjNine, .shelfObjTen, .shelfObjEleven, .shelfObjTwelve, .shelfObjThirteen]
    }
    
    private var decorLocations: [Location] {
        [.decorOne, .decorTwo, .decorThree, .decorFour, .decorFive, .decorSix, .decorSeven, .decorEight]
    }
}

#Preview {
    PurchasedItems()
        .environment(WormProfile())
}
