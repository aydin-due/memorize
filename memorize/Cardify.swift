//
//  Cardify.swift
//  memorize
//
//  Created by aydin salman on 08/09/23.
//

import SwiftUI

struct Cardify: ViewModifier  {
    let isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            let base =  RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                content
                
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
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
