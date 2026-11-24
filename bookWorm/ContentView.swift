//
//  ContentView.swift
//  BookWormTrials
//
//  Created by Sarah Chang on 7/19/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var showTimer = false
    @State private var showStore = false
    @State private var isShowingStorePurchaseView = false
    @State private var selectedStoreItem = Catalog().catalog[0][0]
    @State private var showWormProfileView = false
    
    @State private var newNumApples: Int = 0

    @State private var elapsedTime: TimeInterval = 0.0
    @AppStorage("readingTimerIsOn") private var isTimerOn: Bool = false
    @AppStorage("readingTimerStartDate") private var timerStartDate: Double = 0.0
    @AppStorage("readingTimerAccumulatedTime") private var accumulatedTime: Double = 0.0

    @State private var endAlertIsPresented: Bool = false
    @State private var tooLongAlert: Bool = false
    
    @State private var timerCancellable: AnyCancellable? = nil
    
    @State private var timer: Timer? = nil
    
    @Environment(WormProfile.self) private var wormProfile
    
    var body: some View {
        
        @Bindable var wormProfile = wormProfile
        
        NavigationStack {
            ZStack {
                ScrollView {
                    ZStack {
                        VStack() {
                            Image("Placeholder")
                                .frame(height: 80)
                            Image("\(wormProfile.decorOne)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .padding(.leading, 250)
                            Image("Placeholder")
                                .frame(height: 80)
                            Image("\(wormProfile.decorTwo)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.trailing, 190)
                            Image("Placeholder")
                                .frame(height: 60)
                            Image("\(wormProfile.decorThree)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.leading, 260)
                            Image("\(wormProfile.decorFour)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.trailing, 275)
                            Image("Placeholder")
                                .frame(height: 80)
                            Image("\(wormProfile.decorFive)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .padding(.leading, 250)
                            Image("Placeholder")
                                .frame(height: 40)
                            Image("\(wormProfile.decorSix)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.trailing, 190)
                            Image("Placeholder")
                                .frame(height: 40)
                            Image("\(wormProfile.decorSeven)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.leading, 260)
                            Image("Placeholder")
                                .frame(height: 30)
                            Image("\(wormProfile.decorEight)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 115)
                                .padding(.trailing, 275)
                            Spacer()
                        } //wall decor
                        .allowsHitTesting(false)
                        VStack() {
                            Image("\(wormProfile.shelfObjectOne)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90)
                                .padding(.leading, 15)
                            Image("Placeholder")
                                .frame(height: 58)
                            Image("\(wormProfile.shelfObjectTwo)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75)
                                .padding(.leading, 55)
                            Image("Placeholder")
                                .frame(height: 52)
                            HStack {
                                Image("\(wormProfile.shelfObjectThree)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 115)
                                Image("\(wormProfile.shelfObjectFour)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .padding(.top, 15)
                            }
                            .padding(.trailing, 125)
                            Image("Placeholder")
                                .frame(height: 57)
                            Image("\(wormProfile.shelfObjectFive)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90)
                                .padding(.trailing, 10)
                            Image("Placeholder")
                                .frame(height: 87)
                            HStack {
                                Image("\(wormProfile.shelfObjectSix)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                                Image("\(wormProfile.shelfObjectSeven)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                            }
                            .padding(.trailing, 105)
                            Image("Placeholder")
                                .frame(height: 34)
                            HStack{
                                Image("\(wormProfile.shelfObjectEight)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                    .padding(.top, 20)
                                Image("\(wormProfile.shelfObjectNine)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                            .padding(.leading, 163)
                            Image("Placeholder")
                                .frame(height: 47)
                            HStack {
                                Image("\(wormProfile.shelfObjectTen)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                                Image("\(wormProfile.shelfObjectEleven)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                                    .padding(.top, 30)
                            }
                            .padding(.trailing, 130)
                            Image("Placeholder")
                                .frame(height: 51)
                            HStack {
                                Image("\(wormProfile.shelfObjectTwelve)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 95)
                                Image("\(wormProfile.shelfObjectThirteen)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 95)
                            }
                            .padding(.leading, 85)
                            Image("Placeholder")
                                .frame(height: 4)
                        } //shelf objects
                        .allowsHitTesting(false)
                        VStack(spacing: 60) {
                            Button {
                                refreshElapsedTime()
                                showTimer = true
                            } label: {
                                ZStack {
                                    if wormProfile.clockNeedStand {
                                        Image("Stand")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 110)
                                            .offset(y: 12)
                                    }
                                    
                                    Image("\(wormProfile.timerButton)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110)
                                }
                            }
                            .padding(.trailing, 200)
                            
                            NavigationLink(destination: Library()) {
                                Image("\(wormProfile.libraryButton)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                            .padding(.leading, 240)
                            
                            Spacer()
                        } //buttons
                        .padding(.top, 65)
                        .zIndex(2)
                        VStack {
                            HStack {
                                Image("\(wormProfile.shelfOne)Medium")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.trailing, 100)
                                    .padding(.top, 160)
                            }
                            HStack {
                                Image("\(wormProfile.shelfTwo)Short")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 190)
                                    .padding(.top)
                            }
                            HStack {
                                Image("\(wormProfile.shelfThree)Long")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 25)
                                    .padding(.trailing, 150)
                                    .padding(.top, 50)
                            }
                            HStack {
                                Image("\(wormProfile.shelfFour)Medium")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 85)
                                    .padding(.top, 30)
                            }
                            HStack {
                                Image("\(wormProfile.shelfFive)Medium")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.trailing, 100)
                                    .padding(.top, 60)
                            }
                            HStack {
                                Image("\(wormProfile.shelfSix)Short")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 190)
                                    .padding(.top)
                            }
                            HStack {
                                Image("\(wormProfile.shelfSeven)Long")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 25)
                                    .padding(.trailing, 150)
                                    .padding(.top, 50)
                            }
                            HStack {
                                Image("\(wormProfile.shelfEight)Medium")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 125)
                                    .padding(.leading, 85)
                                    .padding(.top, 30)
                            }
                        } //shelves
                        .allowsHitTesting(false)
                        VStack(spacing: 57) {
                            Image("Placeholder")
                                .frame(height: 385)
                            ZStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        showWormProfileView = true
                                    }
                                } label: {
                                    Image("\(wormProfile.selectedWorm.description)RestingLeft")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 75)
                                    .offset ( x: 0, y: wormProfile.selectedWorm.wormPosition.yOffset)
                                }
                                .buttonStyle(.plain)
                                VStack(alignment: .leading) {
                                    Image(wormProfile.scarf)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: wormProfile.selectedWorm.scarfPosition.height)
                                        .padding(.trailing, wormProfile.selectedWorm.scarfPosition.trailingPadding)
                                        .offset(
                                            x: 0,
                                            y: wormProfile.selectedWorm.scarfPosition.yOffset
                                        )
                                }
                                .allowsHitTesting(false)
                                VStack(alignment: .leading) {
                                    Image(wormProfile.hat)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: wormProfile.selectedWorm.hatPosition.height)
                                        .padding(.trailing, wormProfile.selectedWorm.hatPosition.trailingPadding)
                                        .offset(
                                            x: 0,
                                            y: wormProfile.selectedWorm.hatPosition.yOffset
                                        )
                                }
                                .allowsHitTesting(false)
                            }
                            Spacer()
                        }//worm
                        .padding(.top, 65)
                        .padding(.top, 100)
                        .padding(.leading, 200)
                    }
                }
                VStack {
                    HStack(spacing: 50) {
                        ZStack {
                            HStack {
                                Image("AppleIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .padding(.leading, 10)
                                Text("\(wormProfile.apples)")
                                    .font(.custom("Gaegu-Bold", size: 32))
                                    .padding(10)
                            }
                        }
                        .background(Color.background.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 2))
                        Button("Store") {
                            showStore.toggle()
                        }
                        .font(.custom("Gaegu-Bold", size: 32))
                        .foregroundStyle(Color.textColor)
                        .padding(10)
                        .background(Color.background.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 2))
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    Spacer()
                    HStack() {
                        NavigationLink(destination: Help()) {
                            ZStack {
                                Circle()
                                    .frame(width: 40)
                                    .foregroundStyle(Color.background.opacity(0.4))
                                Circle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 40)
                                Text("?")
                                    .font(.custom("Gaegu-Bold", size: 36))
                                    .foregroundStyle(Color.textColor)
                            }
                        }
                        .padding(.leading, 435)
                        .padding(.bottom, 5)
                        Spacer()
                    }
                } //apples and store
                //Button("Reset Setup") {UserDefaults.standard.set(false, forKey: "hasCompletedSetUp")}
            }
            .background(
                ZStack{
                    Color.background.ignoresSafeArea()
                    
                    Image(wormProfile.wallpaper)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                }
            )
        }
        .overlay {
            if showStore {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    Store(selectedItem: $selectedStoreItem, isShowingPurchaseView: $isShowingStorePurchaseView, isShowingStore: $showStore)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .transition(.opacity.combined(with: .scale(scale: 0.96)))
                    
                    if isShowingStorePurchaseView {
                        PurchaseView(selectedItem: $selectedStoreItem, isShowingPurchaseView: $isShowingStorePurchaseView)
                            .transition(.opacity.combined(with: .scale(scale: 0.96)))
                            .zIndex(1)
                    }
                }
                .transition(.opacity)
            }
        }
        .overlay {
            if showWormProfileView {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showWormProfileView = false
                            }
                        }
                    
                    ZStack(alignment: .topTrailing) {
                        WormProfileView()
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showWormProfileView = false
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
                        .padding(.top, -12)
                        .padding(.trailing, -12)
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.96)))
                }
                .transition(.opacity)
            }
        }
        .overlay {
            if showTimer {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Text(formatTime(elapsedTime))
                            .font(.custom("Gaegu-Regular", size: 48))
                            .padding()
                        
                        // Control buttons
                        HStack(spacing: 20) {
                            Button("Reset", action: resetTimer)
                                .font(.custom("Gaegu-Regular", size: 25))
                                .foregroundStyle(Color.textColor)
                            
                            Button(isTimerOn ? "Pause" : "Start", action: toggleTimer)
                                .font(.custom("Gaegu-Regular", size: 25))
                                .foregroundStyle(Color.textColor)
                            
                            Button("End", action: endTimer)
                                .font(.custom("Gaegu-Regular", size: 25))
                                .foregroundStyle(Color.textColor)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .frame(width: 320, height: 260)
                    .background(Color.background)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                    
                    if endAlertIsPresented {
                        VStack(spacing: 16) {
                            Text("Congratulations!")
                                .font(.custom("Gaegu-Bold", size: 34))
                            
                            Text("\(formatAlertMessage(elapsedTime))\nYou earned ^[\(newNumApples) apple](inflect: true)!")
                                .font(.custom("Gaegu-Regular", size: 24))
                                .multilineTextAlignment(.center)
                            
                            Button("OK") {
                                endAlertIsPresented = false
                                showTimer = false
                                resetTimer()
                            }
                            .font(.custom("Gaegu-Bold", size: 24))
                            .buttonStyle(.borderedProminent)
                            .tint(Color.blue)
                        }
                        .foregroundStyle(Color.textColor)
                        .padding(24)
                        .frame(width: 300)
                        .background(Color.background, in: RoundedRectangle(cornerRadius: 20))
                    }
                }
                .transition(.opacity)
                .onAppear {
                    refreshElapsedTime()
                }
                .alert("Warning", isPresented: $tooLongAlert) {
                    Button("OK") {
                        showTimer = false
                    }
                } message: {
                    Text("\(formatAlertMessage(elapsedTime))\nYou earned ^[\(newNumApples) apple](inflect: true)! Let's take a break.")
                }
            }
        }
        .animation(.default, value: showTimer)
        .onAppear {
            refreshElapsedTime()
            if isTimerOn {
                startTimer()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func toggleTimer() {
        refreshElapsedTime()
        
        if isTimerOn {
            accumulatedTime = elapsedTime
            timerStartDate = 0.0
            isTimerOn = false
            timer?.invalidate()
            timer = nil
        } else {
            timerStartDate = Date().timeIntervalSince1970
            isTimerOn = true
            startTimer()
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            refreshElapsedTime()
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        isTimerOn = false
        timerStartDate = 0.0
        accumulatedTime = 0.0
        elapsedTime = 0.0
    }

    private func endTimer() {
        timer?.invalidate()
        timer = nil
        refreshElapsedTime()
        isTimerOn = false
        timerStartDate = 0.0
        accumulatedTime = elapsedTime
        wormProfile.totalTime += elapsedTime
        GoogleSheetsSyncManager.shared.updateTotalReadingTime(Int(wormProfile.totalTime))
        newNumApples = convertToApples(elapsedTime)
        endAlertIsPresented = true
        wormProfile.apples += newNumApples
    }
    
    private func refreshElapsedTime() {
        guard isTimerOn, timerStartDate > 0 else {
            elapsedTime = accumulatedTime
            return
        }
        
        let startDate = Date(timeIntervalSince1970: timerStartDate)
        elapsedTime = accumulatedTime + Date().timeIntervalSince(startDate)
    }
    
    private func convertToApples(_ time: TimeInterval) -> Int {
        Int(time / 60)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        let tenths = Int((time.truncatingRemainder(dividingBy: 1)) * 10)
        
        return String(format: "%02d:%02d:%02d.%d", hours, minutes, seconds, tenths)
    }
    
    private func formatAlertMessage(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        
        return "You read for \(hours) hours, \(minutes) minutes, and \(seconds) seconds!"
    }
}

#Preview {
    ContentView()
        .environment(WormProfile())
}
