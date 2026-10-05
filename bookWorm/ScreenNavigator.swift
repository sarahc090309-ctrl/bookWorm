//
//  AppNavigator.swift
//  bookWorm
//
//  Created by Sarah Chang on 7/25/26.
//

import SwiftUI

struct ScreenNavigator: View {
    @AppStorage("hasCompletedSetUp") private var hasCompletedSetUp: Bool = false
    
    
    var body: some View {
        ZStack {
            if hasCompletedSetUp {
                ContentView()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                BookWormSetUp(hasCompletedSetUp: $hasCompletedSetUp)
                    .transition(.opacity)
                    .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: hasCompletedSetUp)
    }
}

#Preview {
    ScreenNavigator()
        .environment(WormProfile())
}
