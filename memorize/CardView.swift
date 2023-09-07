//
//  CardView.swift
//  memorize
//
//  Created by aydin salman on 07/09/23.
//

import SwiftUI

struct CardView: View {
    // (var > let if optional so that it can change, otherwise it'd just use the default value)
    // @State adds a pointer to the var so that it doesn't change
    typealias Card = MemoryGame<String>.Card
    let card: Card
    init(_ card: Card) {
        self.card = card
    }
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
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
            }
            //.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View{
        CardView(Card(isFaceUp: true, content: "sisiwawadjshwa djfs sdhs dfs", id: "si"))
            .padding()
            .foregroundColor(.orange)
    }
}