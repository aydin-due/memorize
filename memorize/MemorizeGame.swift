//
//  MemorizeGame.swift
//  memorize
//
//  Created by aydin salman on 23/08/23.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUpp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
