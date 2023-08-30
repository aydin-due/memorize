//
//  MemoryGame.swift
//  memorize
//
//  Created by aydin salman on 24/08/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) it's read-only, can't change the var
    private(set) var cards: Array<Card>
    
    init(pairsQuantity: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, pairsQuantity) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
         
    }

    func choose(_ card: Card) {

    }
    
    //mutating kw so that ur aware it's gonna do a copy on write
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content), \(isFaceUp ? "up" : "down") \(isMatched ? ", matched" : "")"
        }
        
        // if all vars are equatable, it's unnecessary to declare the == function
        /*
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
         */
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String
    }
}
