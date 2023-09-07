//
//  AspectVGrid.swift
//  memorize
//
//  Created by aydin salman on 07/09/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader{ geometry in
        let gridSize = gridWidth(count: items.count, size: geometry.size, aspectRatio: aspectRatio)
        LazyVGrid(columns: [GridItem(.adaptive(minimum: gridSize), spacing: 0)], spacing: 0) {
            ForEach(items) {
                item in content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        }}
        
    }
    
    func gridWidth(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat{
        // overriding the variable w/ another value (scoping)
        let count = CGFloat(count)
        var cols = 1.0
        repeat {
            let width = size.width / cols
            let height = width / aspectRatio
            let rows = (count/cols).rounded(.up)
            if rows * height < size.height {
                return (size.width / cols).rounded(.down)
            }
            cols += 1
        } while cols < count
        return min(size.width / count, size.height*aspectRatio).rounded(.down)
    }
    
}
