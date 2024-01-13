//
//  GameFieldView.swift
//  Set
//
//  Created by Егор Малыгин on 12.09.2023.
//

import UIKit

func gridSize(for elements: Int) -> Int {
    let root = Float(elements).squareRoot()
    let fraction = root.truncatingRemainder(dividingBy: 1)
    return Int(root) + Int(fraction.rounded(.up))
}

class GameFieldView: UIView {
    
    private(set) var cardViews: [SetCardButton] = []
    var selection: Selection = .empty {
        didSet{
            for cardView in cardViews {
                cardView.cardSelected = selection.isSelected(card: cardView.card)
            }
        }
    }
    
    var cards: [Card] = [] {
        didSet{
            for (card, cardView) in zip(cards, cardViews){
                cardView.card = card
            }
            let diff = cardViews.count - cards.count
            if diff > 0 {
                for cardView in cardViews.suffix(diff){
                    cardView.removeFromSuperview()
                }
                cardViews.removeLast(diff)
            } else {
                for card in cards.suffix(-diff) {
                    let view = SetCardButton(card: card)
                    cardViews.append(view)
                    addSubview(view)
                }
            }
        }
    
    }

    func cardsLayout() -> [CGRect] {
        let gridSize = gridSize(for: cards.count)
        var res: [CGRect] = []
        let spaceCount = gridSize - 1
        let size = CGSize(
            width: (self.bounds.width - CGFloat(spaceCount) * 8) / CGFloat(gridSize),
            height: (self.bounds.height - CGFloat(spaceCount) * 8) / CGFloat(gridSize)
        )
        print(8.0/Double(size.height), 8.0/Double(size.width))
        for i in 0..<cards.count {
            let row = i / gridSize
            let column = i % gridSize

            let origin = CGPoint(
                x: CGFloat(column) * (size.width + 8),
                y: CGFloat(row) * (size.height + 8)
            )
            res.append(CGRect(origin: origin, size: size))

        }

        return res
    }
    
    override func layoutSubviews() {
        for(rect, cardView) in zip(cardsLayout(), cardViews) {
            cardView.frame = rect
        }
        
    }
    
    func createViews() {
        for card in cards {
            let view = SetCardButton(card: card)
            cardViews.append(view)
            addSubview(view)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder )
        createViews()
    }
}
