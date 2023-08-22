//
//  ContentView.swift
//  memorize
//
//  Created by aydin salman on 20/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    // (var > let if optional so that it can change, otherwise it'd just use the default value)
    // @State adds a pointer to the var so that it doesn't change
    @State var isFaceUp = false
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
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🫥").font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            //print("tapped!")
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
