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
    
    var upsideCardIndex: Int?

    mutating func choose(_ card: Card) {
        //print("chose \(card)")
        if let chosenCard = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenCard].isFaceUp && !cards[chosenCard].isMatched {
                if let previousCard = upsideCardIndex {
                    if cards[chosenCard].content == cards[previousCard].content {
                        cards[chosenCard].isMatched = true
                        cards[previousCard].isMatched = true
                    }
                    upsideCardIndex = nil
                } else {
                    for index in cards.indices {
                        cards[index].isFaceUp = false
                    }
                    upsideCardIndex = chosenCard
                }
                cards[chosenCard].isFaceUp = true
            }
        }
    }
    
    /*
    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    */
    
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
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
    }
}
