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
    
    let confettiView = ConfettiView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confettiView.startAnimating()
        if let scores = UserDefaults.standard.value(forKeyPath: "allScores") as? [Int] {
            updatedHighScore.text = "High Score: \(scores.max() ?? 0)"
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAgain(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
