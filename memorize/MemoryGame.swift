//
//  MemoryGame.swift
//  memorize
//
//  Created by aydin salman on 24/08/23.
//

import Foundation

struct MemoryGame<CardContent> {
    // private(set) it's read-only, can't change the var
    private(set) var cards: Array<Card>
    
    init(pairsQuantity: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, pairsQuantity) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
         
    }

    func choose(_ card: Card) {

    }
    
    //mutating kw so that ur aware it's gonna do a copy on write
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
