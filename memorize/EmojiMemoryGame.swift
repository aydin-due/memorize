//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by aydin salman on 24/08/23.
//

import SwiftUI

/*
func createCardContent(forPairAtIndex index: Int) -> String {
    return ["🫥", "🐦", "🫧","🧊", "🏖️", "♨️", "🔶", "🎴", "❣️", "📚", "🦦", "👹"][index]
}
*/

class EmojiMemoryGame: ObservableObject {
    // static makes the variable global but namespaces it in the class
    private static let emojis = ["🫥", "🐦", "🫧","🧊", "🏖️", "♨️", "🔶", "🎴", "❣️", "📚", "🦦", "👹"]
    // private changes from partial to full separation, so that the view doesn't access the model
    //@Publoshed notifies when it changes
    @Published private var model = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(pairsQuantity: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]}
            else {
                return "💀"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // intent functions
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model.restart()
    }
}
