//
//  RatingView.swift
//  BookWormTrials
//
//  Created by Sarah Chang on 7/20/26.
//


import SwiftUI

struct RatingView: View {
    // 1. Core Binding property changed to Double for fractional values
    @Binding var rating: Double
    
    var maxRating: Int = 5
    var starSize: CGFloat = 30
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...maxRating, id: \.self) { index in
                let starIndex = Double(index)
                
                GeometryReader { proxy in
                    Image(starImageName(for: starIndex))
                        .resizable()
                        .scaledToFit()
                        .frame(width: starSize, height: starSize)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    selectRating(for: starIndex, at: value.location.x, width: proxy.size.width)
                                }
                        )
                }
                .frame(width: starSize, height: starSize)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Rating")
        .accessibilityValue(String(format: "%.1f out of %d", rating, maxRating))
    }
    
    private func starImageName(for index: Double) -> String {
        if rating >= index {
            return "FilledStar"
        } else if rating >= index - 0.5 {
            return "HalfStar"
        } else {
            return "GrayStar"
        }
    }
    
    private func selectRating(for starIndex: Double, at tapX: CGFloat, width: CGFloat) {
        let selectedValue = tapX < width / 2 ? starIndex - 0.5 : starIndex
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            rating = rating == selectedValue ? 0 : selectedValue
        }
    }
}


#Preview {
    // Previewing with a constant state mapping
    RatingView(rating: .constant(3))
}
