//
//  Settings.swift
//  bookWorm
//
//  Created by Sarah Chang on 8/15/26.
//

import SwiftUI

struct Help: View {
    var body: some View{
        Form() {
            Section(header: Text("Help")
                .font(.custom("Gaegu-Bold", size: 32))
                .foregroundStyle(Color.textColor)) {
                }
            Section(header: Text("To set a reading timer")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                Text("Click on the clock icon to set a reading timer.")
                    .font(.custom("Gaegu-Regular", size: 20))
                    .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To earn apples")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                Text("Set a timer and read! The longer you read, the more apples you'll earn. You can use apples to buy new items in the store.")
                    .font(.custom("Gaegu-Regular", size: 20))
                    .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To add a book to your library")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Click on the books to go to your library. Then, click the \"Add Books\" button to add a book to your library. You can also rate it out of five and write what you think!")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To buy new items")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Go to the \"Store\" at the top of the screen. You can buy new buttons for your timer, your library, as well as decorations for your room and accessories for your worm! If you want to rearrange your items, you can do so by clicking the \"Purchased Items\" tab in the store.")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
            Section(header: Text("Want to know the programmer of this app?")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Hi! I'm Sarah, the student programmer who made this app. If you have questions, reach out to me at book.worm.app9@gmail.com. Happy reading!")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
        }
        .scrollContentBackground(.hidden)
        .background(Color.background)
    }
}

#Preview {
    Help()
}
