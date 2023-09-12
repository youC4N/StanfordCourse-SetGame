//
//  ViewController.swift
//  Set
//
//  Created by Егор Малыгин on 27.07.2023.
//


//TODO: restart Button + add3Button + score + theme
import UIKit

class ViewController: UIViewController {
    
    var game = SetGame()
    
    
    
    @IBOutlet var cardButtons: [SetCardButton]!
    
    
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
    
    
    @IBAction func touchSetCard(_ sender: SetCardButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber)
            game.matchSelectedCards()
            updateViewFromModel()



        }
        
    }
    
    func updateViewFromModel() {
        if game.matches >= 0 {
            gameScoreLabel.text = String(format: "%03d", game.matches)
        } else {
            gameScoreLabel.text = "-\(String(format: "%03d", -game.matches))"
        }
        for (idx, button) in cardButtons.enumerated() {
            button.cardSelected = game.isSelected(at: idx)
            button.card = game.card(at: idx)
//            button.setTitle(game.hand[indx].description, for: .normal)
        }
    }
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.backgroundColor = .white
        //self.view.backgroundColor = UIColor.red
        
        updateViewFromModel()
        
//        for (idx, button) in cardButtons.enumerated() {
//               button.card = game.hand[idx] // Set the card property
               // Other button setup code...
//           }
//        for (idx, button) in cardButtons.enumerated() {
//            button.setTitle(game.cards[idx].description, for: .normal)
//        }
    }


}

extension Card.Color {
    func toUIColor() -> UIColor {
        switch self{
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}

