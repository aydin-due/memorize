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
        /*
        ZStack {
            // can declare variables (let > var bc it can't change)
            let base =  RoundedRectangle(cornerRadius: Constants.cornerRadius)
            // let x = 1
            // can't make operations on vars
            // x = x+1
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.fontSize))
                            .minimumScaleFactor(Constants.minimumScaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.inset)
                
            }
            //.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
         */
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.fontSize))
                    .minimumScaleFactor(Constants.minimumScaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
    
    struct Constants {
        static var lineWidth: CGFloat = 2
        static var fontSize: CGFloat = 200
        static var cornerRadius: CGFloat = 12
        static var minimumScaleFactor = 0.01
        static var inset: CGFloat = 7
        struct Pie {
            static var inset: CGFloat = 5
            static var opacity: CGFloat = 0.4
        }
        
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
