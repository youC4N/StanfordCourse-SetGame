//
//  SetCardView.swift
//  Set
//
//  Created by Егор Малыгин on 27.07.2023.
//

import UIKit


class SetCardView: UIView {
    
    func foo(in path: UIBezierPath)->UIBezierPath{
        
        path.move(to: CGPoint (x: bounds.width/2, y: bounds.height/2))
        path.addLine(to: CGPoint (x: bounds.width/2, y: bounds.height/2))
        path.addLine(to: CGPoint (x: bounds.width/2, y: bounds.height/2))
        path.close()
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3.0
        path.fill()
        path.stroke()
        return path
        
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint (x: bounds.width/2, y: 48))
        path.addLine(to: CGPoint (x: bounds.width/2+12, y: 48+24))
        path.addLine(to: CGPoint (x: bounds.width/2-12, y: 48+24))
        path.close()
        UIColor.green.setFill()
        UIColor.red.setStroke()
        //path.fill()
        path.stroke()
        path.lineWidth = 3.0
        path.move(to: CGPoint (x: bounds.width/2, y: 8))
        path.addLine(to: CGPoint (x: bounds.width/2+12, y: 8+24))
        path.addLine(to: CGPoint (x: bounds.width/2-12, y: 8+24))
        path.close()
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3.0
        //path.fill()
        path.stroke()
        path.move(to: CGPoint (x: bounds.width/2, y: 48+40))
        path.addLine(to: CGPoint (x: bounds.width/2+12, y: 88+24))
        path.addLine(to: CGPoint (x: bounds.width/2-12, y: 88+24))
        path.close()
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = 3.0
        //path.fill()
        path.stroke()
        
        
        
        
    }
    
    enum FigurePattern: String {
        case striped = "striped"
        case solid = "solid"
        case open = "open"
    }
    
    
}
