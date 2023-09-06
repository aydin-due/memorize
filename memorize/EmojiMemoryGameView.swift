//
//  ContentView.swift
//  memorize
//
//  Created by aydin salman on 20/08/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // @StateObject - var exists only when the view's active
    // @ObservedObject - var's lifetime is where it comes from (the app or another view)
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Text("matching \(viewModel.theme.name)")
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("New game"){
                viewModel.restart()
            }
        }
        .padding() 
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            // this is dependent on the card index, not the card itself
            /*
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
            */
            // \.self means to identify the thing w/ itself
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
        }
        .foregroundColor(viewModel.theme.color)
    }
}

struct CardView: View {
    // (var > let if optional so that it can change, otherwise it'd just use the default value)
    // @State adds a pointer to the var so that it doesn't change
    let card: MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
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
                    .aspectRatio(1, contentMode: .fit)
            }
            //.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
