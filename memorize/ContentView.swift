//
//  ContentView.swift
//  memorize
//
//  Created by aydin salman on 20/08/23.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["🫥", "🐦", "🫧","🧊", "🏖️", "♨️", "🔶", "🎴", "❣️", "📚", "🦦", "👹"]
    @State var cardCount = 4
    var body: some View {
        VStack {
            cards
            cardButtons
        }
        .padding()
    }
    
    var cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
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
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.medium)
        .font(.title)
    }
    
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
}

struct CardView: View {
    // (var > let if optional so that it can change, otherwise it'd just use the default value)
    // @State adds a pointer to the var so that it doesn't change
    @State var isFaceUp = true
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
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base
            }
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
