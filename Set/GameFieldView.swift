//
//  GameFieldView.swift
//  Set
//
//  Created by Егор Малыгин on 12.09.2023.
//

import UIKit

func portraitGridSize(for elements: Int) -> (columns: Int, rows: Int) {
    let root = Double(elements).squareRoot()
    let width = Int(root.rounded(.up))
    let height = Double(elements) / Double(width)
    return (columns: width, rows: Int(height.rounded(.up)))
}

let SPACING_FRACTION = 4.5
func landscapeGridSize(for elements: Int) -> (columns: Int, rows: Int) {
    let ratio = (Double(elements)*SPACING_FRACTION).squareRoot()
    let width = Int(ratio.rounded(.up))
    let height = Double(elements) / Double(width)
    return (columns: width, rows: Int(height.rounded(.up)))
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
        let gridSize: (columns: Int, rows: Int)
        switch UIDevice.current.orientation {
        case .landscapeLeft,.landscapeRight:
            gridSize = landscapeGridSize(for: cards.count)
        default:
            gridSize = portraitGridSize(for: cards.count)
        }
        
        var res: [CGRect] = []
        let spaceCount = (
            horizontal: CGFloat(gridSize.columns - 1),
            vertical: CGFloat(gridSize.rows - 1))
        let cardSize = CGSize(
            width: (self.bounds.width - spaceCount.horizontal * 8) / CGFloat(gridSize.columns),
            height: (self.bounds.height - spaceCount.vertical * 8) / CGFloat(gridSize.rows)
        )
        
        for i in 0..<cards.count {
            let row = i / gridSize.columns
            let column = i % gridSize.columns

            let origin = CGPoint(
                x: CGFloat(column) * (cardSize.width + 8),
                y: CGFloat(row) * (cardSize.height + 8)
            )
            res.append(CGRect(origin: origin, size: cardSize))
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
