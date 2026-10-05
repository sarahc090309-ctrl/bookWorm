//
//  WormProfile.swift
//  bookWorm
//
//  Created by Sarah Chang on 8/16/26.
//

import SwiftUI

struct WormProfileView: View {
    
    @Environment(WormProfile.self) private var wormProfile
    
    @AppStorage("installDate") private var installTimestamp: Double = 0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.background)
                .frame(width: 300, height: 420)
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.blue, lineWidth: 2))
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 250, height: 250)
                        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color.blue, lineWidth: 2))
                    Image("\(wormProfile.selectedWorm.description)RestingLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    VStack(alignment: .leading) {
                        Image(wormProfile.scarf)
                            .resizable()
                            .scaledToFit()
                            .frame(height: wormProfile.selectedWorm.wormProfileScarfPosition.height)
                            .padding(.trailing, wormProfile.selectedWorm.wormProfileScarfPosition.trailingPadding)
                            .offset(
                                x: 0,
                                y: wormProfile.selectedWorm.wormProfileScarfPosition.yOffset
                            )
                    }
                    VStack(alignment: .leading) {
                        Image(wormProfile.hat)
                            .resizable()
                            .scaledToFit()
                            .frame(height: wormProfile.selectedWorm.wormProfileHatPosition.height)
                            .padding(.trailing, wormProfile.selectedWorm.wormProfileHatPosition.trailingPadding)
                            .offset(
                                x: 0,
                                y: wormProfile.selectedWorm.wormProfileHatPosition.yOffset
                            )
                    }
                    .allowsHitTesting(false)
                }
                Text(wormProfile.name)
                    .font(.custom("Gaegu-Bold", size: 32))
                    .foregroundStyle(Color.textColor)
                Text("Age: \(yearsSinceDownload)")
                    .font(.custom("Gaegu-Bold", size: 24))
                    .foregroundStyle(Color.textColor)
                Text("Total reading time: \(formattedTime(wormProfile.totalTime))")
                    .font(.custom("Gaegu-Bold", size: 24))
                    .foregroundStyle(Color.textColor)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 10)
            }
            .frame(width: 300)
        }
    }
    
    var yearsSinceDownload: Int {
            guard installTimestamp > 0 else { return 0 }
            let installDate = Date(timeIntervalSince1970: installTimestamp)
            let components = Calendar.current.dateComponents([.year], from: installDate, to: Date())
            return components.year ?? 0
        }
    func formattedTime(_ interval: TimeInterval) -> String {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, [.hour], [.minute], [.second]]
            formatter.unitsStyle = .abbreviated
            formatter.maximumUnitCount = 4
            return formatter.string(from: interval) ?? ""
        }
}

#Preview{
    WormProfileView()
        .environment(WormProfile())
}
