//
//  Help.swift
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
                Text("Click on the clock icon to set a reading timer. To start the timer, click \"Start\" button on the popup. Once the timer is going, the start button will become a pause button, which can be used when you want to take a temporary break without ending the reading session. The reading session can be ended when \"End\" is pressed and the timer will reset when \"Reset\" is pressed. Please be careful; the reset button will set your timer back to zero.")
                    .font(.custom("Gaegu-Regular", size: 20))
                    .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To earn apples")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                Text("Set a timer and read! Each minute that you read is the equivalent of one apple. You can use these apples to buy new items in the store for you worm or your homepage.")
                    .font(.custom("Gaegu-Regular", size: 20))
                    .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To add a book to your library")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Click on the icon of books on the second shelf down to go to your library. Then, click the \"Add Books\" button at the bottom of your screen to add a book to your library. You can also rate it out of five and write a few quick thoughts about it! \n\nDisclaimer: the searching function is not perfect. Please type out the full title of the book you are looking for if it does not pop up quickly. If it still is not appearing, you may have to input the author and cover manually. I apologize for the inconvenience.")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To buy new items")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Go to the \"Store\" at the top of the screen, located next to your apple count. You can buy new buttons for your timer, your library, as well as decorations for your room and accessories for your worm! If you want to rearrange your items, you can do so by clicking the \"Purchased Items\" tab in the store. Just click on the item that you would like to move and its new location. There is a total of eight shelves on the homescreen if you scroll down, so there's plenty of space for optimal customization!")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
            Section(header: Text("To track your progress")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("Click on your worm on the fourth shelf down. This will open a popup with your worm, complete with any accessories you may have bought them. Underneath is your worm's name, their age(how long you have had the app), and your total reading time.")
                        .font(.custom("Gaegu-Regular", size: 20))
                        .foregroundStyle(Color.textColor)
                }
            Section(header: Text("Additional questions?")
                .font(.custom("Gaegu-Regular", size: 25))
                .foregroundStyle(Color.textColor)) {
                    Text("If you have any further questions, comments, or concerns, please email book.worm.app9@gmail.com or reach out @book_worm.app on Instagram. Happy reading!")
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
