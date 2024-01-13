//
//  SetCardButton.swift
//  Set
//
//  Created by Егор Малыгин on 04.08.2023.
//

import UIKit

class SetCardButton: UIButton {

    init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        addTarget(nil, action: #selector(ViewController.touchSetCard), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    var card: Card {
        didSet {
            setNeedsDisplay()
        }
    }

    var cardSelected = false {
        didSet {
            if oldValue != cardSelected {
                setNeedsDisplay()
            }
        }
    }

    func drawShape(in rect: CGRect, color: UIColor, pattern: Card.Pattern, figure: Card.Figure) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.saveGState()  // Save the current graphics state

        // Create a path for the figure inside the bounds
        var shapePath = UIBezierPath()
        let shapeCenter = CGPoint(x: rect.midX, y: rect.midY)

        switch figure {
        case .oval:
            shapePath = UIBezierPath(ovalIn: CGRect(x: rect.minX, y: rect.minY+rect.height/8, width: rect.width, height: rect.height-rect.height/4))
        case .diamond:
            shapePath.move(to: CGPoint(x: shapeCenter.x, y: rect.minY+rect.height/8))
            shapePath.addLine(to: CGPoint(x: rect.maxX, y: shapeCenter.y))
            shapePath.addLine(to: CGPoint(x: shapeCenter.x, y: rect.maxY-rect.height/8))
            shapePath.addLine(to: CGPoint(x: rect.minX, y: shapeCenter.y))
            shapePath.close()
        case .squiggle:
            print()
            shapePath.move(to: squiggleShape.start.translated(into: rect))
            for point in squiggleShape.curve{
                shapePath.addCurve(
                    to: point.point.translated(into: rect),
                    controlPoint1: point.handleA.translated(into: rect),
                    controlPoint2: point.handleB.translated(into: rect))
            }
            shapePath.close()
            

        }

        // Clip the graphics context to the figure's path
        shapePath.addClip()

        // Draw the outline of the figure
        color.setStroke()
        shapePath.lineWidth = 3.0
        shapePath.stroke()

        // Now draw the pattern within the outlined figure
        switch pattern {
        case .open:
            print()
        // Draw open pattern
        case .solid:
            print()

            card.color.toUIColor().setFill()
            shapePath.fill()
        // Draw solid pattern
        case .striped:
            // Draw striped pattern

            // Calculate line spacing and draw vertical lines
            var lineSpacing: CGFloat = Double(rect.width) * 0.15
            if  Double(lineSpacing) < 3.5 {
                lineSpacing = 3.5
            }
            for x in stride(from: rect.minX, to: rect.maxX + rect.height, by: lineSpacing) {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x: x, y: rect.minY))
                linePath.addLine(to: CGPoint(x: x - rect.height/2, y: rect.maxY))
                linePath.lineWidth = 2
                //print(2 / Double(self.bounds.width))
                color.setStroke()
                linePath.stroke()
            }
        }

        context.restoreGState()  // Restore the graphics state
    }

    override func draw(_ rect: CGRect) {
        if cardSelected == true {
            let selectionPath = UIBezierPath()
            selectionPath.move(to: CGPoint(x: 0, y: 0))
            selectionPath.addLine(to: CGPoint(x: bounds.maxX, y: 0))
            selectionPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
            selectionPath.addLine(to: CGPoint(x: 0, y: bounds.maxY))
            selectionPath.addLine(to: CGPoint(x: 0, y: 0))
            selectionPath.close()
            UIColor.green.setStroke()
            selectionPath.lineWidth = Double(self.bounds.width) * 0.1
            selectionPath.stroke()
        }
        
        for rect in figureBounds(count: card.count) {
            drawShape(
                in: rect,
                color: card.color.toUIColor(),
                pattern: card.pattern,
                figure: card.figure)
        }
    }

    static let PADDING: CGFloat = 10
    static let MAX_FIGURES = 3
    static let GAP: CGFloat = 4

    static func totalGaps(forFigureCount count: Int) -> CGFloat {
        return CGFloat(count - 1) * Self.GAP
    }

    func figureBounds(count: Card.Count) -> [CGRect] {
        let innerHeight = bounds.height - 2.0 * Self.PADDING  // nMaxHeight
        let size =
            (innerHeight - Self.totalGaps(forFigureCount: Self.MAX_FIGURES))
            / CGFloat(Self.MAX_FIGURES)
        let nXHeight = size * count.asCGFloat + Self.totalGaps(forFigureCount: count.asInt)
        let offset = Self.PADDING + (innerHeight - nXHeight) / 2.0
        
        return (0..<count.asInt).map { idx in
            CGRect(
                x: Self.PADDING,
                y: offset + CGFloat(idx) * (Self.GAP + size),
                width: bounds.width - 2.0 * Self.PADDING,
                height: size
            )
        }
    }
}

extension CGPoint {
    func translated(into rect: CGRect) -> Self {
        Self(x: rect.minX + self.x * rect.width,
             y: rect.minY + self.y * rect.height)
    }
}
