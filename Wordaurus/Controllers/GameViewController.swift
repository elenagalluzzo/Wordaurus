//
//  GameViewController.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var word: UILabel!
    @IBOutlet weak var typeAnswer: UITextField!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    
    var synomymsArray = [String]()
    var scoreArray = [Int]()
    var gameLength = 30
    var timePassed = 0
    var wordsModel = WordsModel()
    var timer = Timer()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeAnswer.delegate = self
        timerProgress.progress = 0.0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wordsModel.wordsArray.shuffle()
        loadWord()
        wordsModel.wordsCorrect = -1
        updateScoreLabel()
        timerProgress.progress = 0.0
        timePassed = 0
        typeAnswer.text = ""
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startAndEndTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startAndEndTimer() {
        if gameLength > timePassed {
            timePassed += 1
            timerProgress.progress = Float(timePassed) / Float (gameLength)
        }
        else {
            endQuiz()
        }
    }
    
    
    func updateScoreLabel() {
        wordsModel.addToScore()
        currentScore.text = "Score: \(wordsModel.wordsCorrect)"
    }
    
    func loadWord() {
        self.word.text = self.wordsModel.getCurrentWord()
        wordsModel.getSynonyms(word: word.text ?? "") { [weak self] error, synonymModel in
            if error != nil {
                return
            }
            if let synonymModel = synonymModel, synonymModel.synonyms.count > 0 {
                self?.synomymsArray = synonymModel.synonyms
            }
        }
        
    }
    
    
    func endQuiz() {
        timer.invalidate()
        scoreArray.append(wordsModel.wordsCorrect)
        if let previosuScores = UserDefaults.standard.value(forKeyPath: "allScores") as? [Int] {
            self.scoreArray.append(contentsOf: previosuScores)
        }
        
        defaults.set(self.scoreArray, forKey: "allScores")
        self.performSegue(withIdentifier: "showScore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScore" {
            if let destinationVC = segue.destination as? ScoreViewController {
                destinationVC.score = "\(wordsModel.wordsCorrect)"
            }
            
        }
    }
    
    
}

extension GameViewController: UITextFieldDelegate {
  
    override var canBecomeFirstResponder: Bool {
           return false
       }
       override var canResignFirstResponder: Bool {
           return false
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        guard let answer = textField.text else { return false }
        if synomymsArray.contains(answer) {
            updateScoreLabel()
        }
        typeAnswer.text = ""
        continueQuiz()
        return true
    }

    func continueQuiz() {
        wordsModel.nextWord()
        loadWord()
    }
}
