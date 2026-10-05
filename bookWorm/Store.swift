//
//  Store.swift
//  bookWorm
//
//  Created by Sarah Chang on 7/29/26.
//

import SwiftUI

struct Store: View {

    @State private var showPurchasedItems = false
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    @Binding var isShowingStore: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.background)
                        .frame(width: 342, height: 700)
                        .padding(.top, 35)
                    DecorationStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                        .offset(x: 5)
                }
                HStack {
                    Button(action: {
                        showPurchasedItems = false
                    }) {
                        Text("Item Store")
                            .font(.custom("Gaegu-Bold", size: 20))
                            .foregroundColor(.background)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    Button(action: {
                        showPurchasedItems = true
                    }) {
                        Text("Purchased Items")
                            .font(.custom("Gaegu-Bold", size: 20))
                            .foregroundColor(.background)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                } //buttons
                .offset(y: -83)
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isShowingPurchaseView = false
                            isShowingStore = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.textColor)
                            .frame(width: 36, height: 36)
                            .background(Color.background)
                            .clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.blue, lineWidth: 2))
                    }
                    .padding(.trailing, 28)
                    .padding(.top, 78)
                }
                Spacer()
            }
        }
        .padding(20)
        .background(Color.clear)
        .overlay{
            if showPurchasedItems{
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.background)
                        .frame(width: 342, height: 700)
                        .padding(.top, 35)
                    
                    PurchasedItems()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                showPurchasedItems = false
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(Color.textColor)
                                    .frame(width: 36, height: 36)
                                    .background(Color.background)
                                    .clipShape(Circle())
                                    .overlay(Circle().strokeBorder(Color.blue, lineWidth: 2))
                            }
                            .padding(.trailing, 28)
                            .padding(.top, 78)
                        }
                        Spacer()
                    }
                }
                .transition(.opacity)
            }
        }
    }
    
    static func priceTag(_ price: Int) -> some View {
        ZStack {
            HStack {
                Text(price > 999 ? "\(price/1000)K" : "\(price)")
                    .font(.custom("Gaegu-Regular", size: 16))
                    .foregroundStyle(Color.textColor)
                    .padding(.leading, 5)
                Image("AppleIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 2)
            }
            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
            .background(Color.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
        }
    }
}

struct DecorationStore: View {
    
    @State private var showClockStore = false
    @State private var showShelfStore = false
    @State private var showLibraryStore = false
    @State private var showShelfObjStore = false
    @State private var showDecorStore = false
    @State private var showWallpaperStore = false
    @State private var showHatStore = false
    @State private var showScarfStore = false
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 100, height: 600)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.blue, lineWidth: 2)
                    )
                    .padding(EdgeInsets(top: 85, leading: 20, bottom: 100, trailing: 0))
                ScrollView {
                    VStack(spacing: 20) {
                        Button {
                            showShelfStore = false
                            showClockStore = true
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("ClockIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showShelfStore = false
                            showClockStore = false
                            showLibraryStore = true
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("LibraryIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = true
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("ShelfIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = false
                            showLibraryStore = false
                            showShelfObjStore = true
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("ShelfObjIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = false
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = true
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("PosterIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = false
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = true
                            showHatStore = false
                            showScarfStore = false
                        } label: {
                            Image("WallPaperIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = false
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = true
                            showScarfStore = false
                        } label: {
                            Image("HatIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button {
                            showClockStore = false
                            showShelfStore = false
                            showLibraryStore = false
                            showShelfObjStore = false
                            showDecorStore = false
                            showWallpaperStore = false
                            showHatStore = false
                            showScarfStore = true
                        } label: {
                            Image("ScarfIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding(10)
                }
                .frame(width: 100, height: 600)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(EdgeInsets(top: 85, leading: 20, bottom: 100, trailing: 0))
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 200, height: 600)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.blue, lineWidth: 2)
                    )
                    .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                    .overlay {
                        if showClockStore {
                            ClockStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showShelfStore {
                            ShelfStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showLibraryStore {
                            LibraryStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showShelfObjStore {
                            ShelfObjStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showDecorStore {
                            DecorStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showWallpaperStore {
                            WallpaperStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showHatStore {
                            HatStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
                    .overlay {
                        if showScarfStore {
                            ScarfStore(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView)
                                .frame(width: 200, height: 600)
                                .padding(EdgeInsets(top: 85, leading: 0, bottom: 100, trailing: 35))
                        }
                    }
            }
        }
    }
}

struct ClockStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var clocks: [Item] {
        catalog.catalog[0]
    }

    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(clocks) { clock in
                            clockButton(clock)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func clockButton(_ clock: Item) -> some View {
        VStack(spacing: 2) {
            Button {
                selectedItem = clock
                withAnimation(.easeInOut(duration: 0.2)) {
                    isShowingPurchaseView = true
                }
            } label: {
                Image(clock.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(clock.price)
        }
    }
}

struct ShelfStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var shelves: [Item] {
        catalog.catalog[1]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(shelves) { shelf in
                            shelfButton(shelf)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func shelfButton(_ shelf: Item) -> some View {

        return VStack(spacing: 2) {
            Button {
                selectedItem = shelf
                isShowingPurchaseView = true
            } label: {
                Image("\(shelf.name)Short")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(shelf.price)
        }
    }
}

struct LibraryStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var libraries: [Item] {
        catalog.catalog[2]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(libraries) { library in
                            libraryButton(library)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func libraryButton(_ library: Item) -> some View {

        return VStack(spacing: 2) {
            Button {
                selectedItem = library
                isShowingPurchaseView = true
            } label: {
                Image("\(library.name)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(library.price)
        }
    }
}

struct ShelfObjStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var shelfObjects: [Item] {
        catalog.catalog[3]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(shelfObjects) { shelfObject in
                            shelfObjButton(shelfObject)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func shelfObjButton(_ shelfObject: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = shelfObject
                isShowingPurchaseView = true
            } label: {
                Image(shelfObject.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(shelfObject.price)
        }
    }
}

struct DecorStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var wallDecors: [Item] {
        catalog.catalog[4]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(wallDecors) { wallDecor in
                            wallDecorButton(wallDecor)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func wallDecorButton(_ wallDecor: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = wallDecor
                isShowingPurchaseView = true
            } label: {
                Image(wallDecor.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(wallDecor.price)
        }
    }
}

struct WallpaperStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var wallpaper: [Item] {
        catalog.catalog[5]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(wallpaper) { wallPaper in
                            wallpaperButton(wallPaper)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func wallpaperButton(_ wallpaper: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = wallpaper
                isShowingPurchaseView = true
            } label: {
                Image(wallpaper.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(wallpaper.price)
        }
    }
}

struct HatStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var hat: [Item] {
        catalog.catalog[6]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(hat) { hat in
                            hatButton(hat)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func hatButton(_ wallpaper: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = wallpaper
                isShowingPurchaseView = true
            } label: {
                Image(wallpaper.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(wallpaper.price)
        }
    }
}

struct ScarfStore: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    var catalog = Catalog()
    
    var scarves: [Item] {
        catalog.catalog[7]
    }
    
    private let columns = [
        GridItem(.fixed(80), spacing: 4),
        GridItem(.fixed(80), spacing: 4)
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack {
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(scarves) { scarf in
                            scarfButton(scarf)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
    }
    
    private func scarfButton(_ scarf: Item) -> some View {
        return VStack(spacing: 2) {
            Button {
                selectedItem = scarf
                isShowingPurchaseView = true
            } label: {
                Image(scarf.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(Color.background, in: RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.blue, lineWidth: 2))
            }
            Store.priceTag(scarf.price)
        }
    }
}

struct PurchaseView: View {
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    
    @Environment(WormProfile.self) private var wormProfile
    
    @State private var isShowingAlert: Bool = false
    @State private var selectedPreviewLocation: Location?
    
    private let catalogItemNames = Set(Catalog().catalog.flatMap { $0.map(\.name) })
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 12) {
                Color.background
                    .frame(width: 300, height: 620)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay {
                        MiniContentPreview(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView, selectedPreviewLocation: $selectedPreviewLocation)
                    }
                
                HStack(spacing: 12) {
                    Button {
                        purchase(selectedItem)
                    } label: {
                        Text("Confirm")
                            .font(.custom("Gaegu-Bold", size: 24))
                            .foregroundStyle(Color.background)
                            .frame(width: 120, height: 44)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button {
                        isShowingPurchaseView = false
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
            
            if isShowingAlert {
                notEnoughApplesAlert
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isShowingAlert)
        .onAppear {
            selectedPreviewLocation = firstAvailablePreviewLocation(for: selectedItem) ?? defaultPreviewLocation(for: selectedItem)
        }
        .onChange(of: selectedItem.name) {
            selectedPreviewLocation = firstAvailablePreviewLocation(for: selectedItem) ?? defaultPreviewLocation(for: selectedItem)
        }
    }
    
    private var notEnoughApplesAlert: some View {
        VStack(spacing: 16) {
            Text("Not Enough Apples")
                .font(.custom("Gaegu-Bold", size: 34))
            
            Text("Read more to earn enough apples before buying this item.")
                .font(.custom("Gaegu-Regular", size: 20))
                .multilineTextAlignment(.center)
            
            Button("OK") {
                isShowingPurchaseView = false
                isShowingAlert = false
            }
            .font(.custom("Gaegu-Bold", size: 24))
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
        }
        .foregroundStyle(Color.textColor)
        .padding(24)
        .frame(width: 350)
        .background(Color.background, in: RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 2)
        }
    }
    
    private func purchase(_ selectedItem: Item) {
        if wormProfile.apples >= selectedItem.price {
            guard let selectedPreviewLocation,
                  locationIsAvailable(selectedPreviewLocation) else { return }
            
            let purchasedItem = Item(
                name: selectedItem.name,
                price: selectedItem.price,
                needsStand: selectedItem.needsStand,
                type: selectedItem.type,
                location: selectedPreviewLocation
            )
            
            wormProfile.apples -= selectedItem.price
            updateWormProfile(for: purchasedItem, at: selectedPreviewLocation)
            wormProfile.purchasedItems.insert(purchasedItem, at: 0)
            isShowingPurchaseView = false
        }
        else {
            isShowingAlert = true
        }
    }
    
    private func updateWormProfile(for item: Item, at location: Location) {
        guard locationMatchesItemType(location, item) else { return }
        
        switch location {
        case .clock:
            wormProfile.timerButton = item.name
            wormProfile.clockNeedStand = item.needsStand
        case .library:
            wormProfile.libraryButton = item.name
        case .wallpaper:
            wormProfile.wallpaper = item.name
        case .hat:
            wormProfile.hat = item.name
        case .scarf:
            wormProfile.scarf = item.name
        case .shelfOne:
            wormProfile.shelfOne = item.name
        case .shelfTwo:
            wormProfile.shelfTwo = item.name
        case .shelfThree:
            wormProfile.shelfThree = item.name
        case .shelfFour:
            wormProfile.shelfFour = item.name
        case .shelfFive:
            wormProfile.shelfFive = item.name
        case .shelfSix:
            wormProfile.shelfSix = item.name
        case .shelfSeven:
            wormProfile.shelfSeven = item.name
        case .shelfEight:
            wormProfile.shelfEight = item.name
        case .shelfObjOne:
            wormProfile.shelfObjectOne = item.name
        case .shelfObjTwo:
            wormProfile.shelfObjectTwo = item.name
        case .shelfObjThree:
            wormProfile.shelfObjectThree = item.name
        case .shelfObjFour:
            wormProfile.shelfObjectFour = item.name
        case .shelfObjFive:
            wormProfile.shelfObjectFive = item.name
        case .shelfObjSix:
            wormProfile.shelfObjectSix = item.name
        case .shelfObjSeven:
            wormProfile.shelfObjectSeven = item.name
        case .shelfObjEight:
            wormProfile.shelfObjectEight = item.name
        case .shelfObjNine:
            wormProfile.shelfObjectNine = item.name
        case .shelfObjTen:
            wormProfile.shelfObjectTen = item.name
        case .shelfObjEleven:
            wormProfile.shelfObjectEleven = item.name
        case .shelfObjTwelve:
            wormProfile.shelfObjectTwelve = item.name
        case .shelfObjThirteen:
            wormProfile.shelfObjectThirteen = item.name
        case .decorOne :
            wormProfile.decorOne = item.name
        case .decorTwo :
            wormProfile.decorTwo = item.name
        case .decorThree :
            wormProfile.decorThree = item.name
        case .decorFour :
            wormProfile.decorFour = item.name
        case .decorFive :
            wormProfile.decorFive = item.name
        case .decorSix :
            wormProfile.decorSix = item.name
        case .decorSeven :
            wormProfile.decorSeven = item.name
        case .decorEight :
            wormProfile.decorEight = item.name
        }
    }
    
    private func locationIsAvailable(_ location: Location) -> Bool {
        if location == .hat || location == .scarf {
            return true
        }
        
        return !catalogItemNames.contains(currentImageName(for: location))
    }
    
    private func currentImageName(for location: Location) -> String {
        switch location {
        case .clock:
            return wormProfile.timerButton
        case .library:
            return wormProfile.libraryButton
        case .wallpaper:
            return wormProfile.wallpaper
        case .hat:
            return wormProfile.hat
        case .scarf:
            return wormProfile.scarf
        case .shelfOne:
            return wormProfile.shelfOne
        case .shelfTwo:
            return wormProfile.shelfTwo
        case .shelfThree:
            return wormProfile.shelfThree
        case .shelfFour:
            return wormProfile.shelfFour
        case .shelfFive:
            return wormProfile.shelfFive
        case .shelfSix:
            return wormProfile.shelfSix
        case .shelfSeven:
            return wormProfile.shelfSeven
        case .shelfEight:
            return wormProfile.shelfEight
        case .shelfObjOne:
            return wormProfile.shelfObjectOne
        case .shelfObjTwo:
            return wormProfile.shelfObjectTwo
        case .shelfObjThree:
            return wormProfile.shelfObjectThree
        case .shelfObjFour:
            return wormProfile.shelfObjectFour
        case .shelfObjFive:
            return wormProfile.shelfObjectFive
        case .shelfObjSix:
            return wormProfile.shelfObjectSix
        case .shelfObjSeven:
            return wormProfile.shelfObjectSeven
        case .shelfObjEight:
            return wormProfile.shelfObjectEight
        case .shelfObjNine:
            return wormProfile.shelfObjectNine
        case .shelfObjTen:
            return wormProfile.shelfObjectTen
        case .shelfObjEleven:
            return wormProfile.shelfObjectEleven
        case .shelfObjTwelve:
            return wormProfile.shelfObjectTwelve
        case .shelfObjThirteen:
            return wormProfile.shelfObjectThirteen
        case .decorOne:
            return wormProfile.decorOne
        case .decorTwo:
            return wormProfile.decorTwo
        case .decorThree:
            return wormProfile.decorThree
        case .decorFour:
            return wormProfile.decorFour
        case .decorFive:
            return wormProfile.decorFive
        case .decorSix:
            return wormProfile.decorSix
        case .decorSeven:
            return wormProfile.decorSeven
        case .decorEight:
            return wormProfile.decorEight
        }
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
    
    private func firstAvailablePreviewLocation(for item: Item) -> Location? {
        availablePreviewLocations(for: item).first { locationIsAvailable($0) }
    }
    
    private func availablePreviewLocations(for item: Item) -> [Location] {
        switch item.type {
        case .clock:
            return [.clock]
        case .shelf:
            return shelfLocations
        case .library:
            return [.library]
        case .shelfObj:
            return shelfObjLocations
        case .decor:
            return decorLocations
        case .wallpaper:
            return [.wallpaper]
        case .hat:
            return [.hat]
        case .scarf:
            return [.scarf]
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
        case .decor :
            return .decorOne
        case .wallpaper:
            return .wallpaper
        case .hat:
            return .hat
        case .scarf:
            return .scarf
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
        case .decor :
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
    
    private var decorLocations : [Location] {
        [.decorOne, .decorTwo, .decorThree, .decorFour, .decorFive, .decorSix, .decorSeven, .decorEight]
    }
}

struct MiniContentPreview: View {
    
    @Environment(WormProfile.self) private var wormProfile
    
    @Binding var selectedItem: Item
    @Binding var isShowingPurchaseView: Bool
    @Binding var selectedPreviewLocation: Location?
    var clearsExistingSelectedItem = false
    
    @State private var scrollPosition = ScrollPosition(edge: .top)
    
    private let contentWidth: CGFloat = 393
    private let contentHeight: CGFloat = 1450
    private let previewTopInset: CGFloat = 30
    private let catalogItemNames = Set(Catalog().catalog.flatMap { $0.map(\.name) })
    
    var body: some View {
        GeometryReader { geometry in
            let scale = geometry.size.width / contentWidth
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Color.clear
                        .frame(height: previewTopInset * scale)
                    contentScreen
                        .frame(width: contentWidth, height: contentHeight)
                        .scaleEffect(scale, anchor: .topLeading)
                        .frame(width: geometry.size.width, height: contentHeight * scale, alignment: .topLeading)
                }
            }
            .scrollIndicators(.visible)
            .defaultScrollAnchor(.top)
            .scrollPosition($scrollPosition)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onAppear {
                resetScroll()
            }
            .onChange(of: selectedItem.name) {
                resetScroll()
            }
            .onChange(of: isShowingPurchaseView) {
                if isShowingPurchaseView {
                    resetScroll()
                }
            }
        }
        .frame(width: 300, height: 620)
        .background(
            ZStack{
                Color.background
                
                wallpaper
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    private func resetScroll() {
        scrollPosition.scrollTo(edge: .top)
        DispatchQueue.main.async {
            scrollPosition.scrollTo(edge: .top)
        }
    }
    
    private var contentScreen: some View {
        ZStack {
            wallDecor
            shelfObjects
            inactiveScreenButtons
            worm
            shelfStack
            topBar
        }
    }
    
    private var inactiveScreenButtons: some View {
        let clockName = previewImageName(for: .clock, currentName: wormProfile.timerButton)
        let clockNeedsStand = selectedPreviewLocation == .clock && selectedItem.type == .clock ? selectedItem.needsStand : wormProfile.clockNeedStand
        let libraryName = previewImageName(for: .library, currentName: wormProfile.libraryButton)
        
        return VStack(spacing: 60) {
            Button {
                updatePreviewImage(at: .clock)
            } label: {
                ZStack {
                    Image(clockName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110)
                    if clockNeedsStand {
                        Image("Stand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                            .offset(x: 0, y: 12)
                    }
                }
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 65)
            
            Button {
                updatePreviewImage(at: .library)
            } label: {
                Image(libraryName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 55)
            
            Spacer()
        }
        .padding(.top, 65)
    }
    
    private var wallpaper: some View {
        let wallpaperName = previewImageName(for: .wallpaper, currentName: wormProfile.wallpaper)
        return ZStack{
            Color.background.ignoresSafeArea()
            
            Image(wallpaperName)
                .resizable()
                .ignoresSafeArea()
        }
    }
    
    private var shelfStack: some View {
        VStack {
            Button {
                updatePreviewImage(at: .shelfOne)
            } label : {
                shelfImage(name: previewImageName(for: .shelfOne, currentName: wormProfile.shelfOne), length: "Medium")
                    .padding(.trailing, 100)
                    .padding(.top, 160)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfTwo)
            } label: {
                shelfImage(name: previewImageName(for: .shelfTwo, currentName: wormProfile.shelfTwo), length: "Short")
                    .padding(.leading, 190)
                    .padding(.top)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfThree)
            } label: {
                shelfImage(name: previewImageName(for: .shelfThree, currentName: wormProfile.shelfThree), length: "Long")
                    .padding(.leading, 25)
                    .padding(.trailing, 150)
                    .padding(.top, 50)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfFour)
            } label: {
                shelfImage(name: previewImageName(for: .shelfFour, currentName: wormProfile.shelfFour), length: "Medium")
                    .padding(.leading, 85)
                    .padding(.top, 30)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfFive)
            } label: {
                shelfImage(name: previewImageName(for: .shelfFive, currentName: wormProfile.shelfFive), length: "Medium")
                    .padding(.trailing, 100)
                    .padding(.top, 60)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfSix)
            } label: {
                shelfImage(name: previewImageName(for: .shelfSix, currentName: wormProfile.shelfSix), length: "Short")
                    .padding(.leading, 190)
                    .padding(.top)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfSeven)
            } label: {
                shelfImage(name: previewImageName(for: .shelfSeven, currentName: wormProfile.shelfSeven), length: "Long")
                    .padding(.leading, 25)
                    .padding(.trailing, 150)
                    .padding(.top, 50)
            }
            .buttonStyle(.plain)
            Button {
                updatePreviewImage(at: .shelfEight)
            } label: {
                shelfImage(name: previewImageName(for: .shelfEight, currentName: wormProfile.shelfEight), length: "Medium")
                    .padding(.leading, 85)
                    .padding(.top, 30)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var worm: some View {
        let wormHat = previewImageName(for: .hat, currentName: wormProfile.hat)
        let wormScarf = previewImageName(for: .scarf, currentName: wormProfile.scarf)
        
        return VStack(spacing: 60) {
            Color.clear
                .frame(height: 385)
            ZStack{
                Image("\(wormProfile.selectedWorm.description)RestingLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                VStack(alignment: .leading){
                    Image(wormHat)
                        .resizable()
                        .scaledToFit()
                        .frame(height: wormProfile.selectedWorm.hatPosition.height)
                        .padding(.trailing, wormProfile.selectedWorm.hatPosition.trailingPadding)
                        .offset(
                            x: 0,
                            y: wormProfile.selectedWorm.hatPosition.yOffset
                        )
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    updatePreviewImage(at: .hat)
                }
                VStack(alignment: .leading) {
                    Image(wormScarf)
                        .resizable()
                        .scaledToFit()
                        .frame(height: wormProfile.selectedWorm.scarfPosition.height)
                        .padding(.trailing, wormProfile.selectedWorm.scarfPosition.trailingPadding)
                        .offset(
                            x: 0,
                            y: wormProfile.selectedWorm.scarfPosition.yOffset
                        )
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    updatePreviewImage(at: .scarf)
                }
            }
            Spacer()
        }
        .padding(.top, 165)
        .padding(.leading, 200)
    }

    private var wallDecor: some View {
        VStack {
            Color.clear
                .frame(height: 80)
            decorButton(.decorOne, currentName: wormProfile.decorOne, width: 100)
                .padding(.leading, 250)
            Color.clear
                .frame(height: 80)
            decorButton(.decorTwo, currentName: wormProfile.decorTwo, width: 115)
                .padding(.trailing, 190)
            Color.clear
                .frame(height: 60)
            decorButton(.decorThree, currentName: wormProfile.decorThree, width: 115)
                .padding(.leading, 260)
            decorButton(.decorFour, currentName: wormProfile.decorFour, width: 115)
                .padding(.trailing, 275)
            Color.clear
                .frame(height: 80)
            decorButton(.decorFive, currentName: wormProfile.decorFive, width: 100)
                .padding(.leading, 250)
            Color.clear
                .frame(height: 40)
            decorButton(.decorSix, currentName: wormProfile.decorSix, width: 115)
                .padding(.trailing, 190)
            Color.clear
                .frame(height: 40)
            decorButton(.decorSeven, currentName: wormProfile.decorSeven, width: 115)
                .padding(.leading, 260)
            Color.clear
                .frame(height: 30)
            decorButton(.decorEight, currentName: wormProfile.decorEight, width: 115)
                .padding(.trailing, 275)
            Spacer()
        }
    }
    
    private var shelfObjects: some View {
        VStack {
            shelfObjectButton(.shelfObjOne, currentName: wormProfile.shelfObjectOne, width: 90)
                .padding(.leading, 15)
            Color.clear
                .frame(height: 58)
            shelfObjectButton(.shelfObjTwo, currentName: wormProfile.shelfObjectTwo, width: 75)
                .padding(.leading, 55)
            Color.clear
                .frame(height: 52)
            HStack {
                shelfObjectButton(.shelfObjThree, currentName: wormProfile.shelfObjectThree, width: 115)
                shelfObjectButton(.shelfObjFour, currentName: wormProfile.shelfObjectFour, width: 100)
                    .padding(.top, 15)
            }
            .padding(.trailing, 125)
            Color.clear
                .frame(height: 57)
            shelfObjectButton(.shelfObjFive, currentName: wormProfile.shelfObjectFive, width: 90)
                .padding(.trailing, 10)
            Color.clear
                .frame(height: 87)
            HStack {
                shelfObjectButton(.shelfObjSix, currentName: wormProfile.shelfObjectSix, width: 90)
                shelfObjectButton(.shelfObjSeven, currentName: wormProfile.shelfObjectSeven, width: 90)
            }
            .padding(.trailing, 105)
            Color.clear
                .frame(height: 34)
            HStack {
                shelfObjectButton(.shelfObjEight, currentName: wormProfile.shelfObjectEight, width: 80)
                    .padding(.top, 20)
                shelfObjectButton(.shelfObjNine, currentName: wormProfile.shelfObjectNine, width: 100)
            }
            .padding(.leading, 163)
            Color.clear
                .frame(height: 47)
            HStack {
                shelfObjectButton(.shelfObjTen, currentName: wormProfile.shelfObjectTen, width: 120)
                shelfObjectButton(.shelfObjEleven, currentName: wormProfile.shelfObjectEleven, width: 90)
                    .padding(.top, 30)
            }
            .padding(.trailing, 130)
            Color.clear
                .frame(height: 51)
            HStack {
                shelfObjectButton(.shelfObjTwelve, currentName: wormProfile.shelfObjectTwelve, width: 95)
                shelfObjectButton(.shelfObjThirteen, currentName: wormProfile.shelfObjectThirteen, width: 95)
            }
            .padding(.leading, 85)
            Color.clear
                .frame(height: 4)
        }
    }
    
    private var topBar: some View {
        VStack {
            HStack(spacing: 50) {
                HStack {
                    Image("AppleIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.leading, 10)
                    Text("\(wormProfile.apples)")
                        .font(.custom("Gaegu-Bold", size: 32))
                        .foregroundStyle(Color.textColor)
                        .padding(10)
                }
                .background(Color.background.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 2))
                
                Text("Store")
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                    .padding(10)
                    .background(Color.background.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 2))
            }
            .frame(maxWidth: .infinity, alignment: .top)
            Spacer()
        }
    }

    private func shelfObjectButton(_ location: Location, currentName: String, width: CGFloat) -> some View {
        Button {
            updatePreviewImage(at: location)
        } label: {
            objectImage(previewImageName(for: location, currentName: currentName), width: width)
                .overlay {
                    if selectedItem.type == .shelfObj {
                        locationOutline(for: location)
                    }
                }
        }
        .buttonStyle(.plain)
    }
    
    private func decorButton(_ location: Location, currentName: String, width: CGFloat) -> some View {
        Button {
            updatePreviewImage(at: location)
        } label: {
            decorImage(previewImageName(for: location, currentName: currentName), width: width)
                .overlay {
                    if selectedItem.type == .decor {
                        locationOutline(for: location)
                    }
                }
        }
        .buttonStyle(.plain)
    }
    
    private func locationOutline(for location: Location) -> some View {
        let isSelected = selectedPreviewLocation == location
        return RoundedRectangle(cornerRadius: 8)
            .strokeBorder(
                Color.blue.opacity(isSelected ? 1 : 0.5),
                style: StrokeStyle(lineWidth: isSelected ? 3 : 2, dash: isSelected ? [] : [6, 4])
            )
    }
    
    func locationIsAvailable(_ place: Location) -> Bool {
        return true
    }
    
    private func updatePreviewImage(at location: Location) {
        //guard locationMatchesSelectedItemType(location),
        //      locationIsAvailable(location) else { return }
        if clearsExistingSelectedItem,
           selectedItem.location == location,
           selectedPreviewLocation == location,
           locationMatchesSelectedItemType(location) {
            selectedPreviewLocation = nil
            return
        }
        
        selectedPreviewLocation = location
    }
    
    private func previewImageName(for location: Location, currentName: String) -> String {
        if selectedPreviewLocation == location && locationMatchesSelectedItemType(location) {
            return selectedItem.name
        }
        
        if clearsExistingSelectedItem && selectedItem.location == location && locationMatchesSelectedItemType(location) {
            return miniPreviewDefaultImageName(for: location)
        }
        
        return currentName
    }
    
    private func miniPreviewDefaultImageName(for location: Location) -> String {
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
    
    private func locationMatchesSelectedItemType(_ location: Location) -> Bool {
        switch selectedItem.type {
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
    
    private var decorLocations : [Location] {
        [.decorOne, .decorTwo, .decorThree, .decorFour, .decorFive, .decorSix, .decorSeven, .decorEight]
    }
    
    private func shelfImage(name: String, length: String) -> some View {
        Image("\(name)\(length)")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 125)
    }
    
    private func decorImage(_ name: String, width: CGFloat) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
    
    private func objectImage(_ name: String, width: CGFloat) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

#Preview {
    @Previewable @State var selectedItem = Catalog().catalog[0][0]
    @Previewable @State var isShowingPurchaseView = false
    @Previewable @State var isShowingStore = true

    Store(selectedItem: $selectedItem, isShowingPurchaseView: $isShowingPurchaseView, isShowingStore: $isShowingStore)
        .environment(WormProfile())
}
    
