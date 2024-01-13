//
//  Card.swift
//  Set
//
//  Created by Егор Малыгин on 03.08.2023.
//

import Foundation

protocol PluralStringConvertible: CustomStringConvertible {
    var pluralOther: String { get }
    var pluralOne: String { get }
    var pluralFew: String { get }
    var pluralMany: String { get }
}

extension PluralStringConvertible {
    var pluralOther:String {pluralOne}
    var pluralOne:String {description}
    var pluralFew:String {pluralOther}
    var pluralMany:String {pluralOther}
    
    func description(for count: Int) -> String {
        if count == 1 {
            return pluralOne
        } else {
            return pluralOther
        }
    }
    
}

struct Card: Equatable, CustomStringConvertible {
    var figure: Figure
    var count: Count
    var color: Color
    var pattern: Pattern
    
    var description: String {
        "\(count)\n\(color)\n\(pattern)\n\(figure.description(for: count.asInt))"
    }
     
    enum Count:UInt8, CaseIterable{
        case one = 1
        case two = 2
        case three = 3
        
        var asInt: Int { Int(self.rawValue) }
        var asCGFloat: CGFloat { CGFloat(self.rawValue) }
    }
    
    enum Figure: CaseIterable, CustomStringConvertible, PluralStringConvertible {
        case diamond
        case squiggle
        case oval
        
        var description: String {
            switch self {
            case .diamond:
                return "diamond"
            case .squiggle:
                return "squiggle"
            case .oval:
                return "oval"
            }
            
        }
        var pluralOther: String {
            switch self{
            case .diamond:
                return "triangles"
            case .squiggle:
                return "squares"
            case .oval:
                return "circles"
            }
        }
        
    }
    
    enum Color: CaseIterable {
        
        case red
        case green
        case blue
        

    }
    
    enum Pattern: CaseIterable {
        case striped
        case solid
        case open
    }
    
    static var all: [Card]{
        var items = [Card]()
        for count in Count.allCases{
            for figure in Figure.allCases{
                for color in Color.allCases{
                    for pattern in Pattern.allCases{
                        items.append(Card(figure: figure, count: count, color: color, pattern: pattern))
                    }
                }
            }
        }
        return items
    }
}
