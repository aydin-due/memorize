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
    private let aspectRatio: CGFloat = 2/3
    
    
    var body: some View {
        VStack {
                cards
                    .animation(.default, value: viewModel.cards)
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        .padding() 
    }
    
    private var cards: some View {
                // this is dependent on the card index, not the card itself
                /*
                 ForEach(viewModel.cards.indices, id: \.self) { index in
                 CardView(viewModel.cards[index])
                 .aspectRatio(2/3, contentMode: .fit)
                 .padding(4)
                 }
                 */
                // \.self means to identify the thing w/ itself
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.color)
                
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
