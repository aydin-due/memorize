//
//  MemoryGame.swift
//  memorize
//
//  Created by aydin salman on 24/08/23.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    // private(set) it's read-only, can't change the var
    private(set) var cards: Array<Card>
    
    init(pairs: Int, content: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        var availablePairs = Array(0..<content)
        for _ in 0..<pairs {
            let random = Int.random(in: 0..<availablePairs.count)
            print("random: \(random)")
            let index = availablePairs.remove(at: random)
            print("index: \(index)")
            let content = cardContentFactory(index)
            print("content: \(content)")
            cards.append(Card(content: content, id: "\(index+1)a"))
            cards.append(Card(content: content, id: "\(index+1)b"))
        }
        shuffle()
         
    }
    
    // computed property
    var upsideCardIndex: Int? {
        get { cards.indices.filter {index in cards[index].isFaceUp }.only }
            /*
            var facedUpCards = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    facedUpCards.append(index)
                }
            }
             */
            //let faceUpCards = cards.indices.filter {index in cards[index].isFaceUp }
            /*
            if facedUpCards.count == 1 {
                return facedUpCards.first
            } else {
                return nil
            }
             */
            //return faceUpCards.count == 1 ? faceUpCards.first : nil
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
            /*
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
             */
            //return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
    }

    mutating func choose(_ card: Card) {
        //print("chose \(card)")
        if let chosenCard = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenCard].isFaceUp && !cards[chosenCard].isMatched {
                if let previousCard = upsideCardIndex {
                    if cards[chosenCard].content == cards[previousCard].content {
                        cards[chosenCard].isMatched = true
                        cards[previousCard].isMatched = true
                    }
                } else {
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
    
    mutating func restart(){
        cards.indices.forEach { cards[$0].isFaceUp = false }
        cards.indices.forEach { cards[$0].isMatched = false }
        shuffle()
    }
    
    struct Theme{
        let name: String, content: [String], pairNumber: Int, color: Color
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
