//
//  ViewController.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet weak var highScore: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scores = UserDefaults.standard.value(forKeyPath: "allScores") as? [Int] {
            highScore.text = "High Score: \(scores.max() ?? 0)"
        }
    }
        // Do any additional setup after loading the view.

}

