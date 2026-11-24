//
//  BookWormSetUp.swift
//  BookWormTrials
//

import SwiftUI

struct BookWormSetUp: View {
    
    @Binding var hasCompletedSetUp: Bool
    
    @Environment(WormProfile.self) private var wormProfile
    
    @State private var step: Int = 1
    @State private var localName: String = ""
    @State private var userAge: Int? = nil
    @State private var selectedReadingFrequency: ReadingFrequency = .never
    @State private var selectedReadingLength: ReadingLength = .never
    @State private var readingTime: Int? = nil
    
    @State private var showAgeQuestionAlert: Bool = false
    
    enum Worm: String, CaseIterable, Identifiable {
        case basic, earth, gummy, silk, fake, string
        
        var id: String { rawValue }
        var description: String {
            switch self {
            case .basic: return "BasicWorm"
            case .earth: return "EarthWorm"
            case .gummy: return "GummyWorm"
            case .silk: return "SilkWorm"
            case .fake: return "FakeWorm"
            case .string: return "StringWorm"
            }
        }
        
        var wormPosition: WormPosition {
            switch self {
            case .basic:
                return WormPosition(yOffset: 0)
            case .earth:
                return WormPosition(yOffset: 4)
            case .gummy:
                return WormPosition(yOffset: 0)
            case .silk:
                return WormPosition(yOffset: 0)
            case .fake:
                return WormPosition(yOffset: 3)
            case .string:
                return WormPosition(yOffset: 0)
            }
        }
        
        var hatPosition: HatPosition {
            switch self {
            case .basic:
                return HatPosition(trailingPadding: 15, yOffset: -22, height: 80)
            case .earth:
                return HatPosition(trailingPadding: 31, yOffset: -18, height: 63)
            case .gummy:
                return HatPosition(trailingPadding: 20, yOffset: -20, height: 76)
            case .silk:
                return HatPosition(trailingPadding: 20, yOffset: -22, height: 75)
            case .fake:
                return HatPosition(trailingPadding: 24, yOffset: -22, height: 68)
            case .string:
                return HatPosition(trailingPadding: 48, yOffset: -28, height: 77)
            }
        }
        
        var scarfPosition: ScarfPosition {
            switch self {
            case .basic:
                return ScarfPosition(trailingPadding: 25, yOffset: 14, height: 45)
            case .earth:
                return ScarfPosition(trailingPadding: 38, yOffset: 10, height: 33)
            case .gummy:
                return ScarfPosition(trailingPadding: 35, yOffset: 11, height: 53)
            case .silk:
                return ScarfPosition(trailingPadding: 32, yOffset: 15, height: 55)
            case .fake:
                return ScarfPosition(trailingPadding: 35, yOffset: 10, height: 48)
            case .string:
                return ScarfPosition(trailingPadding: 57, yOffset: 6, height: 55)
            }
        }
        
        var wormProfileHatPosition: WormProfileHatPosition {
            switch self {
            case .basic:
                return WormProfileHatPosition(trailingPadding: 30, yOffset: -40, height: 160)
            case .earth:
                return WormProfileHatPosition(trailingPadding: 67, yOffset: -42, height: 126)
            case .gummy:
                return WormProfileHatPosition(trailingPadding: 44, yOffset: -43, height: 152)
            case .silk:
                return WormProfileHatPosition(trailingPadding: 40, yOffset: -44, height: 150)
            case .fake:
                return WormProfileHatPosition(trailingPadding: 48, yOffset: -48, height: 136)
            case .string:
                return WormProfileHatPosition(trailingPadding: 52, yOffset: -30, height: 100)
            }
        }
        var wormProfileScarfPosition: WormProfileScarfPosition {
            switch self {
            case .basic:
                return WormProfileScarfPosition(trailingPadding: 53, yOffset: 27, height: 90)
            case .earth:
                return WormProfileScarfPosition(trailingPadding: 78, yOffset: 20, height: 66)
            case .gummy:
                return WormProfileScarfPosition(trailingPadding: 75, yOffset: 19, height: 106)
            case .silk:
                return WormProfileScarfPosition(trailingPadding: 73, yOffset: 25, height: 110)
            case .fake:
                return WormProfileScarfPosition(trailingPadding: 68, yOffset: 17, height: 96)
            case .string:
                return WormProfileScarfPosition(trailingPadding: 63, yOffset: 10, height: 75)
            }
        }
    }
    struct WormPosition {
        let yOffset: CGFloat
    }
    struct HatPosition {
        let trailingPadding: CGFloat
        let yOffset: CGFloat
        let height: CGFloat
    }
    
    struct ScarfPosition {
        let trailingPadding: CGFloat
        let yOffset: CGFloat
        let height: CGFloat
    }
    
    struct WormProfileHatPosition {
        let trailingPadding: CGFloat
        let yOffset: CGFloat
        let height: CGFloat
    }
    
    struct WormProfileScarfPosition {
        let trailingPadding: CGFloat
        let yOffset: CGFloat
        let height: CGFloat
    }
    
    
    enum ReadingFrequency: Int, CaseIterable, Identifiable, CustomStringConvertible {
        case never = 0, fewTimesAYear, everyFewMonths, atLeastOnceAMonth, everyWeek, everyCoupleDays, everyDay, moreThanOnceADay
        
        var id: Int { rawValue }
        var description: String {
            switch self {
            case .never: return "Never"
            case .fewTimesAYear: return "A few times a year"
            case .everyFewMonths: return "Every few months"
            case .atLeastOnceAMonth: return "At least once a month"
            case .everyWeek: return "Every week"
            case .everyCoupleDays: return "Every couple of days"
            case .everyDay: return "Every day"
            case .moreThanOnceADay: return "More than once a day"
            }
        }
    }
    
    enum ReadingLength: Int, CaseIterable, Identifiable, CustomStringConvertible {
        case never = 0, five, ten, twenty, thirty, sixty, ninety, oneTwenty
        
        var id: Int { rawValue }
        var description: String {
            switch self {
            case .never: return "I don't read"
            case .five: return "5-10 minutes"
            case .ten: return "10-20 minutes"
            case .twenty: return "20-30 minutes"
            case .thirty: return "30-60 minutes"
            case .sixty: return "60-90 minutes"
            case .ninety: return "90-120 minutes"
            case .oneTwenty: return "Over 120 minutes"
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.background.ignoresSafeArea()
            
            VStack {
                Group {
                    switch step {
                    case 1: welcomeStep
                    case 2: meetWormStep
                    case 3: pickWormStep
                    case 4: nameWormStep
                    case 5: questionsIntroStep
                    case 6: ageStep
                    case 7: frequencyStep
                    case 8: durationStep
                    case 9: goalIntroStep
                    case 10: goalSetupStep
                    case 11: completeStep
                    default: Text("Setup Complete")
                    }
                }
                .transition(.push(from: .trailing))
                .animation(.easeInOut, value: step)
            }
            .animation(.default, value: step)
            .padding()
            
            if showAgeQuestionAlert {
                ageQuestionOverlay
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showAgeQuestionAlert)
    }
    
    private var welcomeStep: some View {
        VStack(spacing: 50) {
            Text("Welcome to BookWorm!")
                .font(.custom("Gaegu-Bold", size: 52))
                .bold()
                .foregroundStyle(Color.textColor)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Button("Let's go!") {
                step = 2
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
    }
    
    private var meetWormStep: some View {
        VStack(spacing: 50) {
            Text("Let's meet your new reading companion!")
                .font(.custom("Gaegu-Bold", size: 32))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textColor)
            
            Button("Next") {
                step = 3
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
    }
    
    private var pickWormStep: some View {
        VStack(spacing: 20) {
            Text("Pick your worm:")
                .font(.custom("Gaegu-Bold", size: 32))
                .foregroundStyle(Color.textColor)
            VStack(spacing: 50) {
                HStack(spacing: 30) {
                    Button {
                        wormProfile.selectedWorm = .basic
                        step = 4
                    } label: {
                        Image("BasicWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                    
                    Button {
                        wormProfile.selectedWorm = .earth
                        step = 4
                    } label: {
                        Image("EarthWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
                HStack(spacing: 30) {
                    Button {
                        wormProfile.selectedWorm = .gummy
                        step = 4
                    } label: {
                        Image("GummyWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                    
                    Button {
                        wormProfile.selectedWorm = .silk
                        step = 4
                    } label: {
                        Image("SilkWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
                HStack(spacing: 30) {
                    Button {
                        wormProfile.selectedWorm = .string
                        step = 4
                    } label: {
                        Image("StringWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 90)
                    }
                    
                    Button {
                        wormProfile.selectedWorm = .fake
                        step = 4
                    } label: {
                        Image("FakeWormResting")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
            }
        }
    }
    
    private var nameWormStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("What is your worm's name?")
                    .font(.custom("Gaegu-Bold", size: 32))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.textColor)
                
                TextField("Name", text: $localName)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.textColor)
                    .font(.custom("Gaegu-Regular", size: 32))
            }
            .padding(.horizontal, 40)
            Button("Next") {
                wormProfile.name = localName.trimmingCharacters(in: .whitespaces)
                step = 5
            }
            .buttonStyle(.borderedProminent)
            .font(.custom("Gaegu-Regular", size: 32))
            .foregroundStyle(Color.textColor)
            .tint(Color.blue)
            .disabled(localName.isEmpty)
        }
    }
    
    private var questionsIntroStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("Great! \(wormProfile.name.isEmpty ? "Your worm" : wormProfile.name) can't wait to start reading!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                Text("But first, here are a few questions about you!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
            }
            .padding(.horizontal, 40)
            Button("Next") {
                step = 6
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
    }
    
    private var ageStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("How old are you?")
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                
                TextField("Age", value: $userAge, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Regular", size: 32))
                    .foregroundStyle(Color.textColor)
            }
            VStack(spacing: 20){
                Button("Next") {
                    step = 7
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(Color.textColor)
                .tint(Color.blue)
                .font(.custom("Gaegu-Regular", size: 32))
                
                Button("What is this information used for?") {
                    showAgeQuestionAlert = true
                }
                .frame(width: 150)
                .font(.custom("Gaegu-Regular", size: 16))
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 40)
        }
    }
    
    private var ageQuestionOverlay: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture {
                    showAgeQuestionAlert = false
                }
            
            VStack(spacing: 20) {
                Text("Information Use")
                    .font(.custom("Gaegu-Bold", size: 34))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                
                Text("Your age will only be used to determine the impact of the app and the demographic it is most effective with. This information will not be used in any other way.")
                    .font(.custom("Gaegu-Regular", size: 24))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 12) {
                    Button("OK") {
                        showAgeQuestionAlert = false
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.blue)
                    .foregroundStyle(Color.textColor)
                    .font(.custom("Gaegu-Regular", size: 26))
                    
                    Button("I do not want to share my age") {
                        userAge = nil
                        showAgeQuestionAlert = false
                        step = 7
                    }
                    .font(.custom("Gaegu-Regular", size: 20))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                }
            }
            .padding(28)
            .frame(maxWidth: 330)
            .background(Color.background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var frequencyStep: some View {
        VStack(spacing: 50) {
            VStack (spacing: 20) {
                Text("How often do you read in your free time now?")
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Picker("Reading Frequency", selection: $selectedReadingFrequency) {
                    ForEach(ReadingFrequency.allCases) { freq in
                        Text(freq.description).tag(freq)
                    }
                    .foregroundStyle(Color.textColor)
                    .font(.custom("Gaegu-Regular", size: 25))
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white))
            }
            Button("Next") {
                step = 8
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
    }
    
    private var durationStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("How long do you typically read for at a time?")
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Picker("Reading Length", selection: $selectedReadingLength) {
                    ForEach(ReadingLength.allCases) { length in
                        Text(length.description).tag(length)
                    }
                    .foregroundStyle(Color.textColor)
                    .font(.custom("Gaegu-Regular", size: 25))
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .padding(.horizontal, 40)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white))
            }
            Button("Next") {
                step = 9
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
    }
    
    private var goalIntroStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("\(wormProfile.name.isEmpty ? "Your worm" : wormProfile.name) can't wait to help you reach your reading goal!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                Text("Let's set your goal now!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
            }
            VStack(spacing: 20) {
                Button("Set a Goal") {
                    step = 10
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                .foregroundStyle(Color.textColor)
                .font(.custom("Gaegu-Regular", size: 32))
                
                Button("I don't want to set a goal") {
                    step = 11
                }
                .foregroundColor(.secondary)
                .font(.custom("Gaegu-Regular", size: 16))
            }
        }
        .padding(.horizontal, 40)
    }
    
    private var goalSetupStep: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                VStack {
                    Text("I would like to read")
                        .font(.custom("Gaegu-Bold", size: 32))
                        .foregroundStyle(Color.textColor)
                    TextField("#", value: $readingTime, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .font(.custom("Gaegu-Bold", size: 32))
                        .foregroundStyle(Color.textColor)
                    Text("minutes every day.")
                        .font(.custom("Gaegu-Bold", size: 32))
                        .foregroundStyle(Color.textColor)
                }
            }
            Button("Next") {
                if let unwrappedReadingTime = readingTime {
                    wormProfile.readingGoal = Double(unwrappedReadingTime) * 60
                }
                step = 11
            }
            .buttonStyle(.borderedProminent)
            .disabled(readingTime == nil)
            .tint(Color.blue)
            .foregroundStyle(Color.textColor)
            .font(.custom("Gaegu-Regular", size: 32))
        }
        .padding(.horizontal, 40)
    }
    
    private var completeStep: some View {
        
            VStack(spacing: 50) {
                Text("You're all set up! Let's go to \(wormProfile.name.isEmpty ? "your worm" : wormProfile.name)'s new home!")
                    .multilineTextAlignment(.center)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                
                Button("Let's go!") {
                    
                    if UserDefaults.standard.object(forKey: "InstallDate") == nil {
                        UserDefaults.standard.set(Date(), forKey: "InstallDate")
                    }
                    
                    GoogleSheetsSyncManager.shared.syncOnboardingData(
                        wormName: wormProfile.name,
                        userAge: userAge,
                        frequency: selectedReadingFrequency.description,
                        length: selectedReadingLength.description,
                        goalMinutes: readingTime,
                        totalReadingTime: wormProfile.totalTime
                    )
                    
                    withAnimation(.easeInOut(duration: 0.35)) {
                        hasCompletedSetUp = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.blue)
                .foregroundStyle(Color.textColor)
                .font(.custom("Gaegu-Regular", size: 32))
            }
            .padding(.horizontal, 40)
    }
}

struct ReadingDataPayload: Codable {
    let userId: String
    let wormName: String
    let userAge: Int?
    let readingFrequency: String
    let readingLength: String
    let dailyGoalMinutes: Int?
    let totalReadingTime: Int
    let daysSinceDownload: Int
}

class GoogleSheetsSyncManager {
    static let shared = GoogleSheetsSyncManager()
    private let webAppURL = "https://script.google.com/macros/s/AKfycbyfUWZW1hI7itsAxrp-tXM4lmFeLyaLagl06GlIi3JC1cwrBnJIu1mKI1lNP6J8oeF5/exec"
    
    func syncOnboardingData(
        wormName: String,
        userAge: Int?,
        frequency: String,
        length: String,
        goalMinutes: Int?,
        totalReadingTime: TimeInterval
    ) {
        guard let url = URL(string: webAppURL) else { return }
        
        let userId = UIDevice.current.identifierForVendor?.uuidString ?? "UnknownUser"
        
        // Calculate days since download
        let installDate = UserDefaults.standard.object(forKey: "InstallDate") as? Date ?? Date()
        let daysSinceDownload = max(0, Calendar.current.dateComponents([.day], from: installDate, to: Date()).day ?? 0)
        
        // Total reading time initialized to 0 during setup
        let payload = ReadingDataPayload(
            userId: userId,
            wormName: wormName,
            userAge: userAge,
            readingFrequency: frequency,
            readingLength: length,
            dailyGoalMinutes: goalMinutes,
            totalReadingTime: Int(totalReadingTime),
            daysSinceDownload: daysSinceDownload
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            print("Failed to encode payload: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error syncing setup data: \(error)")
                return
            }
            print("Successfully sent setup data to Google Sheets!")
        }.resume()
    }
    
    func updateTotalReadingTime(_ newTotalMinutes: Int) {
        UserDefaults.standard.set(newTotalMinutes, forKey: "TotalReadingTime")
        sendSyncRequest()
    }
    
    func sendSyncRequest()
    {
        guard let url = URL(string: webAppURL) else { return }
        let defaults = UserDefaults.standard
        
        let userId = UIDevice.current.identifierForVendor?.uuidString ?? "UnknownUser"
        let installDate = defaults.object(forKey: "InstallDate") as? Date ?? Date()
        let daysSinceDownload = max(0, Calendar.current.dateComponents([.day], from: installDate, to: Date()).day ?? 0)
        
        let payload = ReadingDataPayload(
            userId: userId,
            wormName: defaults.string(forKey: "WormName") ?? "Unknown",
            userAge: defaults.object(forKey: "UserAge") as? Int,
            readingFrequency: defaults.string(forKey: "ReadingFrequency") ?? "",
            readingLength: defaults.string(forKey: "ReadingLength") ?? "",
            dailyGoalMinutes: defaults.object(forKey: "DailyGoalMinutes") as? Int,
            totalReadingTime: defaults.integer(forKey: "TotalReadingTime"),
            daysSinceDownload: daysSinceDownload
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(payload)
        } catch {
            print("Failed to encode payload: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("Network error syncing data: \(error)")
                return
            }
            print("Successfully synced reading data to Google Sheets")
        }.resume()
    }
}

#Preview {
    BookWormSetUp(hasCompletedSetUp: .constant(false))
        .environment(WormProfile())
}
