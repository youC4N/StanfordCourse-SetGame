//
//  Set.swift
//  Set
//
//  Created by Егор Малыгин on 03.08.2023.
//

import Foundation

struct SetGame {
    var hand: [Card]
    var deckOfCards: [Card]
    var matches = 0
    private var selection = Selection.empty

    static let STARTING_HAND = 12
    static let MAX_HAND = 24

    init() {
        let cards = Card.all.shuffled()
        hand = Array(cards[..<Self.STARTING_HAND])
        deckOfCards = Array(cards[Self.STARTING_HAND...])
        print(deckOfCards.count)
    }

    mutating func addThreeMoreCards() {
        guard
            case let (first?, second?, third?) =
                (
                    deckOfCards.popLast(),
                    deckOfCards.popLast(),
                    deckOfCards.popLast()
                ),
            hand.count < Self.MAX_HAND
        else { return }

        hand.append(first)
        hand.append(second)
        hand.append(third)

    }

    mutating func chooseCard(at index: Int) {
        guard let card = hand[safe: index] else { return }
        selection = selection.toggle(card: card)
    }
    func isSelected(at index: Int) -> Bool {
        guard let card = hand[safe: index] else { return false }
        return selection.isSelected(card: card)
    }
    func card(at index: Int) -> Card? { hand[safe: index] }
    func satisfiesSet<T: Equatable>(
        given cards: (Card, Card, Card),
        withProperty property: KeyPath<Card, T>
    ) -> Bool {
        let (a, b, c) = cards
        let (pa, pb, pc) = (a[keyPath: property], b[keyPath: property], c[keyPath: property])
        return (pa == pb && pb == pc) || (pa != pc && pc != pb)
    }

    func isSet(given cards: (Card, Card, Card)) -> Bool {
        [
            satisfiesSet(given: cards, withProperty: \.color),
            satisfiesSet(given: cards, withProperty: \.figure),
            satisfiesSet(given: cards, withProperty: \.count),
            satisfiesSet(given: cards, withProperty: \.pattern),
        ].allSatisfy { $0 }
    }

    mutating func matchSelectedCards() {
        guard case .three(let card1, let card2, let card3) = selection else { return }

        self.selection = .empty

        guard isSet(given: (card1, card2, card3)) else { self.matches -= 3; return }

        let changedIndicies = (
            hand.firstIndex(of: card1)!,
            hand.firstIndex(of: card2)!,
            hand.firstIndex(of: card3)!
        )

        guard
            case let (first?, second?, third?) = (
                deckOfCards.popLast(), deckOfCards.popLast(), deckOfCards.popLast()
            )
        else {
            //hand.remove(at: changedIndicies.0)
            let removingElements: [Card] = [
                hand[changedIndicies.0], hand[changedIndicies.1], hand[changedIndicies.2],
            ]

            hand.removeAll(where: { removingElements.contains($0) })
            return
        }

        hand[changedIndicies.0] = first
        hand[changedIndicies.1] = second
        hand[changedIndicies.2] = third
        
        self.matches += 1

        // TODO: self.matches += 1

    }
}

enum Selection: Equatable {
    case empty
    case one(Card)
    case two(Card, Card)
    case three(Card, Card, Card)

    func remove(card: Card) -> Selection {
        switch self {
        case .empty:
            return .empty
        case .one(let first):
            if first == card {
                return .empty
            } else {
                return .one(first)
            }
        case .two(let first, let second):
            if first == card {
                return .one(second)
            } else if second == card {
                return .one(first)
            } else {
                return .two(first, second)
            }
        case .three(let first, let second, let third):
            if first == card {
                return .two(second, third)
            } else if second == card {
                return .two(first, third)
            } else if third == card {
                return .two(first, second)
            } else {
                return .three(first, second, third)
            }

        }
    }

    func toggle(card: Card) -> Selection {
        if !self.isSelected(card: card) {
            return self.add(card: card)
        } else {
            return self.remove(card: card)
        }
    }

    func add(card: Card) -> Selection {

        switch self {
        case .empty:
            return .one(card)
        case .one(let first):
            return .two(first, card)
        case .two(let first, let second):
            return .three(first, second, card)
        case .three(_, _, _):
            return .one(card)

        }

    }

    func isSelected(card: Card) -> Bool {

        switch self {
        case .empty:
            return false
        case .one(let first):
            return first == card
        case .two(let first, let second):
            return first == card || second == card
        case .three(let first, let second, let third):
            return first == card || second == card || third == card

        }
    }

}

//switch self {
//// Remove if present
//case .one(card): return .empty
//case .two(card, let first): fallthrough
//case .two(let first, card): return .one(first)
//case .three(card, let first, let second): fallthrough
//case .three(let first, card, let second): fallthrough
//case .three(let first, let second, card): return .two(first, second)
//
//// Add if absent
//case .empty: return .one(card)
//case .two(let first, let second): return .three(first, second, card)
//case .one(let first): return .two(first, card)
//// There cannot be more than three cards
//case .three(_, _, _): return .empty
//}

//    switch self {
//    case .one(card): return .empty
//    case .two(card, let first): fallthrough
//    case .two(let first, card): return .one(first)
//    case .three(card, let first, let second): fallthrough
//    case .three(let first, card, let second): fallthrough
//    case .three(let first, let second, card): return .two(first, second)
//    default: return self
//    }

//        let a: Optional<Int> = Optional.none
//        let b: Optional<Int> = Optional.some(42)
//
//        let c: Int? = nil
//        let d: Int? = 42

//        let x: Selection = .one()
//        switch x {
//
//        case .empty:
//
//        case .one(var card):
//
//            card.color = .green
//        case .two(_, _):
//
//        case .three(_, _, _):
//
//        }

extension Array {
    subscript(safe index: Int) -> Element? {
        if index < count { return self[index] } else { return nil }
    }
}
