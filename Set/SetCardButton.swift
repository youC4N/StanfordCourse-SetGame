//
//  SetCardButton.swift
//  Set
//
//  Created by Егор Малыгин on 04.08.2023.
//

import UIKit

class SetCardButton: UIButton {
    
    var card: Card? {
        didSet {
            if oldValue != card {
                setNeedsDisplay()
            }
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
        
        context.saveGState() // Save the current graphics state
        
        // Create a path for the figure inside the bounds
        let shapePath = UIBezierPath()
        let shapeCenter = CGPoint(x: rect.midX, y: rect.midY)
        
        switch figure {
        case .circle:
            shapePath.addArc(withCenter: shapeCenter, radius: rect.width / 2, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        case .triangle:
            shapePath.move(to: CGPoint(x: shapeCenter.x, y: rect.minY))
            shapePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            shapePath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            shapePath.close()
        case .square:
            print()
            shapePath.move(to: rect.origin)
            shapePath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            shapePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            shapePath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
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
            
            
            card?.color.toUIColor().setFill() ?? UIColor.black.setFill()
            shapePath.fill()
            // Draw solid pattern
        case .striped:
            // Draw striped pattern
            
            // Calculate line spacing and draw vertical lines
            let lineSpacing: CGFloat = 7.0 // Adjust as needed
            
            //var currentY: CGFloat = rect.maxY
            
            for x in stride(from: rect.minX, to: rect.maxX + rect.height, by: lineSpacing) {
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x: x, y: rect.minY ))
                linePath.addLine(to: CGPoint(x: x - rect.width , y: rect.maxY ))
                linePath.lineWidth = 2.0
                color.setStroke()
                linePath.stroke()
            }
        }
        
        context.restoreGState() // Restore the graphics state
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
            selectionPath.lineWidth = 8.0
            selectionPath.stroke()
        }
        
        if let card = card {
            self.alpha = 1.0
            for rect in figureBounds(count: card.count) {
                drawShape(in: rect, color: card.color.toUIColor(), pattern: card.pattern, figure: card.figure)
            }
        } else {
            self.alpha = 0.0
        }
    }
    
    static let PADDING: CGFloat = 10
    static let MAX_FIGURES = 3
    static let GAP: CGFloat = 4
    
    static func totalGaps(forFigureCount count: Int) -> CGFloat {
        return CGFloat(count - 1) * Self.GAP
    }


    
    func figureBounds(count: Card.Count) -> [CGRect] {
        let innerHeight = bounds.height - 2.0 * Self.PADDING // nMaxHeight
        let size = (innerHeight - Self.totalGaps(forFigureCount: Self.MAX_FIGURES)) / CGFloat(Self.MAX_FIGURES)
        let nXHeight = size * count.asCGFloat + Self.totalGaps(forFigureCount: count.asInt)
        let offset = Self.PADDING + (innerHeight - nXHeight) / 2.0
        
        return (0..<count.asInt).map { idx in
            CGRect(
                x: self.bounds.width / 2.0 - size / 2.0,
                y: offset + CGFloat(idx) * (Self.GAP + size),
                width: size,
                height: size
            )
        }
    }
}

//extension Array {
//  init(size: Int, initialize: (Int) -> Element) {
//      self.init(unsafeUninitializedCapacity: size) { buffer, initializedCount in
//      for i in 0..<size {
//        buffer[i] = initialize(i)
//      }
//      initializedCount = size
//    }
//  }
//}


        
//        if let card = card {
//            let path = UIBezierPath()
//            switch card.color{
//            case .blue:
//                UIColor.blue.setStroke()
//
//            case .red:
//                UIColor.red.setStroke()
//            case .green:
//                UIColor.green.setStroke()
//            }
//            if card.pattern == .striped {
//                path.lineWidth = 2.0
//                path.setLineDash([4, 4], count: 2, phase: 0)
//            } else {
//                path.lineWidth = 3.0
//            }
//            switch card.count{
//            case .one:
////                path.move(to: CGPoint(x: bounds.maxX/2, y: bounds.maxY/2))
//                path.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
//                switch card.figure {
//                    //let figureSize: Double = (bounds.height-16)/3
//                case .circle:
//                    path.move(to:CGPoint( x: bounds.midX + (bounds.height-16)/3, y: bounds.midY))
//                    path.addArc(withCenter:  CGPoint(x: bounds.midX, y: bounds.midY), radius: (bounds.height-16)/6, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//                    print("size = \((bounds.height-16)/3)")
//                    //path.lineWidth = 3.0
//                    path.stroke()
//                case .square:
//                    path.move(to: CGPoint( x: bounds.midX + (bounds.height-16)/6, y: bounds.midY + (bounds.height-16)/6))
//                    path.addLine(to: CGPoint(x: bounds.midX + (bounds.height-16)/6, y: bounds.midY - (bounds.height-16)/6))
//                    path.addLine(to: CGPoint(x: bounds.midX - (bounds.height-16)/6 , y: bounds.midY - (bounds.height-16)/6))
//                    path.addLine(to: CGPoint(x: bounds.midX - (bounds.height-16)/6 , y: bounds.midY + (bounds.height-16)/6))
//                    path.close()
//                    print("size rect = \( (bounds.height-16)/3)")
//                    //path.lineWidth = 3.0
//                    path.stroke()
//                case .triangle:
//                    let radius: Double = ((bounds.height-16)/(6))
//
//                    let a: Double = radius * sqrt(3)
//                    let ax: Double = a / 2
//                    let ay: Double = (radius*3)/2
//
//                    path.move(to: CGPoint( x: bounds.midX, y: bounds.midY - (bounds.height-16)/6))
//                    path.addLine(to: CGPoint(x: Double(bounds.midX + ax), y: Double(bounds.midY - (bounds.height-16)/6 + ay)))
//                    path.addLine(to: CGPoint(x: Double(bounds.midX + ax - a), y: Double(bounds.midY - (bounds.height-16)/6 + ay)))
//                    path.close()
////                    path.addLine(to: CGPoint( x: Double(bounds.midX) + ax, y: Double(bounds.midY - (bounds.height-16)/6)+ ay))
//                    path.lineWidth = 3.0
//                    path.stroke()
//
//
//
//                default: print("yes")
//                }
//
//            case .two:
//                print()
//                //path.move(to: CGPoint(x: bounds.maxX/2, y: bounds.maxY/4))
//            case .three:
//                print()
//                //path.move(to: CGPoint(x: bounds.maxX/2, y: bounds.maxY/6))
//            }


//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        let image = createImage(rect: self.bounds)
//        self.setBackgroundImage(image, for: .normal)
//       }
//
//
//       func createImage(rect: CGRect) -> UIImage{
//
//           UIGraphicsBeginImageContext(rect.size)
//
//           let context = UIGraphicsGetCurrentContext();
//
//           //just a circle
//           context!.setFillColor(UIColor.purple.cgColor);
//           context!.fillEllipse(in: CGRectInset(rect, 4, 4));
//           context!.strokePath();
//
//           let image =  UIGraphicsGetImageFromCurrentImageContext()!;
//
//           UIGraphicsEndImageContext()
//
//           return image
//       }


