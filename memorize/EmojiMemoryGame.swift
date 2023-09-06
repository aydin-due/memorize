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
    //private static let emojis = ["🫥", "🐦", "🫧","🧊", "🏖️", "♨️", "🔶", "🎴", "❣️", "📚", "🦦", "👹"]
    // private changes from partial to full separation, so that the view doesn't access the model
    //@Published notifies when it changes
    @Published private var model = createMemoryGame()
    
    private static var themes: Array<MemoryGame<String>.Theme> = [
        MemoryGame<String>.Theme(name: "animals", content: ["🪱", "🐢", "🦧", "🐯", "🐜", "🦋", "🐹", "🐶", "🐻‍❄️"], pairNumber: 6, color: .blue),
        MemoryGame<String>.Theme(name: "food", content: ["🥑", "🍞", "🌯", "🍟", "🥗", "🍎", "🥨", "🧀"], pairNumber: 6, color: .red),
        MemoryGame<String>.Theme(name: "objects", content: ["📸", "💿", "🔋", "⏳", "🧨"], pairNumber: 4, color: .orange),
        MemoryGame<String>.Theme(name: "sports", content: ["🏀", "🎱", "🏈", "🥎", "🎾","🏐","🏄", "🛼", "⛸️", "🥊", "⛳️"], pairNumber: 8, color: .yellow),
        MemoryGame<String>.Theme(name: "flags", content: ["🇧🇴", "🇨🇻", "🇧🇹", "🇨🇦", "🇦🇸", "🇩🇲", "🇱🇹", "🇾🇹"], pairNumber: 8, color: .green),
        MemoryGame<String>.Theme(name: "symbols", content: ["✤", "☆", "◎", "❖", "☮︎", "►"], pairNumber: 4, color: .black)
    ]
    
    private static var theme: MemoryGame<String>.Theme?
    
    private static func createMemoryGame() -> MemoryGame<String>{
        theme = themes.randomElement() ?? themes.first
        return MemoryGame(pairs: theme!.pairNumber, content: theme!.content.count) { pairIndex in
            if theme!.content.indices.contains(pairIndex) {
                return theme!.content[pairIndex]}
            else {
                return "💀"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme {
        return EmojiMemoryGame.theme!
    }
    
    var score: Int {
        return model.score
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
        model = EmojiMemoryGame.createMemoryGame()
    }
}
