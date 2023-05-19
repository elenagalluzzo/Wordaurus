//
//  ScoreViewController.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import UIKit
import ConfettiView



class ScoreViewController: UIViewController {

    @IBOutlet weak var finalScore: UILabel!
    @IBOutlet weak var updatedHighScore: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    var score: String = ""
    
    let confettiView = ConfettiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScore.layer.cornerRadius = 10
        finalScore.layer.masksToBounds = true
        playAgainButton.layer.cornerRadius = 10
        setupConfettiView()
        if let scores = UserDefaults.standard.value(forKeyPath: "allScores") as? [Int] {
            updatedHighScore.text = "High Score: \(scores.max() ?? 0)"
        }
        updateScore(score: score)
    }
    
    func setupConfettiView() {
        confettiView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confettiView)
        confettiView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        confettiView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        confettiView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        confettiView.startAnimating()
        //stop after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.confettiView.stopAnimating()
            UIView.animate(withDuration: 5, delay: 7, options: .curveEaseIn, animations: {
            }) { _ in
                self.confettiView.removeFromSuperview()
            }
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func updateScore(score: String) {
        finalScore.text = score
    }
}
