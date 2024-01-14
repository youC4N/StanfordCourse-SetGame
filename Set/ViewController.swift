//
//  ViewController.swift
//  Set
//
//  Created by Егор Малыгин on 27.07.2023.
//

//TODO: restart Button + add3Button + score + theme
import UIKit

class ViewController: UIViewController {

    @IBAction func shuffleOnRotation(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.shuffleHand()
            updateViewFromModel()
        default:
            break
        }
        
    }
    @IBOutlet weak var gameField: GameFieldView!
    
    var game = SetGame()

    @IBAction func touchAddThreeMoreCards(_ sender: UIButton) {
        game.addThreeMoreCards()
        updateViewFromModel()
    }

    @IBOutlet weak var restartButton: UIButton!

    @IBAction func touchRestart(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }

    @IBOutlet weak var gameScoreLabel: UILabel!

    @objc func touchSetCard(_ sender: SetCardButton) {
        game.choose(card: sender.card)
        game.matchSelectedCards()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        if game.matches >= 0 {
            gameScoreLabel.text = String(format: "%03d", game.matches)
        } else {
            gameScoreLabel.text = "-\(String(format: "%03d", -game.matches))"
        }
        gameField.selection = game.selection
        gameField.cards = game.hand
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.backgroundColor = .white
        updateViewFromModel()
        adjustInsets()
    }
    
    func adjustInsets() {
        var additionalInsets = UIEdgeInsets.zero
        let sides = [\UIEdgeInsets.left, \.right, \.top, \.bottom]
        for side in sides where view.safeAreaInsets[keyPath: side] == 0 {
            additionalInsets[keyPath: side] = 8
        }
        additionalSafeAreaInsets = additionalInsets
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.adjustInsets()
    }
    
    @IBAction func handleSwipeUp(_ sender: UISwipeGestureRecognizer) {
        self.game.addThreeMoreCards()
        updateViewFromModel()
    }
}

extension Card.Color {
    func toUIColor() -> UIColor {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}
