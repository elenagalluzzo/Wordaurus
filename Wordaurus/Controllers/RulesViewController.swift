//
//  ViewController.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var playLabel: UIButton!
    @IBOutlet weak var rulesDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playLabel.layer.cornerRadius = 10
        rulesDescription.layer.cornerRadius = 10
        rulesDescription.layer.masksToBounds = true
        if let scores = UserDefaults.standard.value(forKeyPath: "allScores") as? [Int] {
            highScore.text = "High Score: \(scores.max() ?? 0)"
        }
    }
}

