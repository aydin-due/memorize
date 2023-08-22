//
//  ContentView.swift
//  memorize
//
//  Created by aydin salman on 20/08/23.
//

import SwiftUI

struct ContentView: View {
    let theme1 = ["🐯", "🪱", "🐢", "🦧", "🐯", "🪱", "🐢", "🦧"]
    let theme2 = ["🥑", "🍞", "🌯", "🍟", "🥗", "🥑", "🍞", "🌯", "🍟", "🥗"]
    let theme3 = ["📸", "💿", "🔋", "⏰", "⏳", "🧨","📸", "💿", "🔋", "⏰", "⏳", "🧨"]
    @State var emojis: [String]
    
    init() {
        emojis = theme1
    }
    var body: some View {
        VStack {
            Text("memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardButtons: some View {
        HStack{
            /*
             Button("add card") {
                cardCount += 1
            }
             */
            theme1Button
            theme2Button
            theme3Button
        }
        .imageScale(.large)
        .font(.subheadline)
    }
    
    var theme1Button: some View {
        themeButton(theme: "animals", cards: theme1, symbol: "pawprint.fill")
    }
    
    var theme2Button: some View {
        themeButton(theme: "food", cards: theme2, symbol: "fork.knife")
    }
    
    var theme3Button: some View {
        themeButton(theme: "objects", cards: theme3, symbol: "tray.fill")
    }
    
    func themeButton(theme: String, cards: [String], symbol: String) -> some View {
        Button(action: {
            emojis = cards.shuffled()
        }, label: {
            VStack{
                Image(systemName: symbol)
                Text(theme)
            }
        })
    }
    
    /*
    var cardRemover: some View {
        cardButton(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardButton(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func cardButton(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
     */
}

struct CardView: View {
    // (var > let if optional so that it can change, otherwise it'd just use the default value)
    // @State adds a pointer to the var so that it doesn't change
    @State var isFaceUp = false
    let content: String
    var body: some View{
        // closure expression syntax
        /*
        ZStack(alignment: .center, content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("🫥").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        })
         */
        // trailing closure syntax
        ZStack {
            // can declare variables (let > var bc it can't change)
            let base =  RoundedRectangle(cornerRadius: 12)
            // let x = 1
            // can't make operations on vars
            // x = x+1
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            //.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            //print("tapped!")
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
