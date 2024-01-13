//
//  Squiggle.swift
//  Set
//
//  Created by Егор Малыгин on 14.01.2024.
//

import Foundation

struct Point {
    var x: CGPoint
    var y: CGPoint
}

struct BezierCurvePoint {
    var point: CGPoint
    var handleA: CGPoint
    var handleB: CGPoint
}

struct BezierShape {
    var start: CGPoint
    var curve: [BezierCurvePoint]
}

let squiggleShape = BezierShape(
    start: CGPoint(x: 0.370253488372093, y: 0.7634590909090909),
    curve: [
        BezierCurvePoint(
            point: CGPoint(x: 0.20760255813953488, y: 0.8777545454545455),
            handleA: CGPoint(x: 0.3000953488372093, y: 0.7607636363636363),
            handleB: CGPoint(x: 0.2679813953488372, y: 0.7799)),
        BezierCurvePoint(
            point: CGPoint(x: 0.03488372093023256, y: 0.6590909090909091),
            handleA: CGPoint(x: 0.14722302325581396, y: 0.9756136363636364),
            handleB: CGPoint(x: 0.035599302325581395, y: 1.04545)),
        BezierCurvePoint(
            point: CGPoint(x: 0.2790674418604651, y: 0.09090909090909091),
            handleA: CGPoint(x: 0.03397906976744186, y: 0.17061909090909091),
            handleB: CGPoint(x: 0.18604418604651163, y: 0.09090909090909091)),
        BezierCurvePoint(
            point: CGPoint(x: 0.6260813953488372, y: 0.250295),
            handleA: CGPoint(x: 0.3720906976744186, y: 0.09090909090909091),
            handleB: CGPoint(x: 0.5073558139534883, y: 0.24531545454545453)),
        BezierCurvePoint(
            point: CGPoint(x: 0.8488348837209302, y: 0.06818181818181818),
            handleA: CGPoint(x: 0.7097837209302326, y: 0.2538059090909091),
            handleB: CGPoint(x: 0.8100744186046511, y: 0.12878772727272728)),
        BezierCurvePoint(
            point: CGPoint(x: 0.965113953488372, y: 0.3181818181818182),
            handleA: CGPoint(x: 0.8837209302325582, y: 0.022727181818181817),
            handleB: CGPoint(x: 0.965113953488372, y: 0.045454545454545456)),
        BezierCurvePoint(
            point: CGPoint(x: 0.6511604651162791, y: 0.8863636363636364),
            handleA: CGPoint(x: 0.965113953488372, y: 0.6590909090909091),
            handleB: CGPoint(x: 0.7921953488372093, y: 0.8886954545454546)),
        BezierCurvePoint(
            point: CGPoint(x: 0.370253488372093, y: 0.7634590909090909),
            handleA: CGPoint(x: 0.5232581395348838, y: 0.8842454545454544),
            handleB: CGPoint(x: 0.4983883720930233, y: 0.768390909090909))
    ]
)
