//
//  WordsModel.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import Foundation

struct WordsModel {
    
    var wordNumber = 0
    
    var wordsCorrect = 0
    
    var wordsArray = ["Poor", "Beautiful", "Different", "Vigor", "Funny", "Memoir", "Vehemence", "Lineage", "Sad", "Significant", "Awful", "Rich", "Begin", "Shimmering", "Crooked", "Palatable", "Counterfeit", "Mimic", "Hate", "Idea", "Mischievous", "Weak", "Story", "Illness", "Run", "Quiet"]
    
    func getCurrentWord() -> String {
        return wordsArray[wordNumber]
    }
    
    mutating func nextWord() {
        if wordNumber < wordsArray.count - 1 {
            wordNumber += 1
        } else {
            wordNumber = 0
        }
    }
    
    mutating func addToScore() {
        wordsCorrect += 1
    }
    
    func getSynonyms(word: String, completionHandler: @escaping(_ error : Error?, _ synonymModel: SynonymModel?)->()) {
        SynonymApi.sharedInstance.callSynonymApi(word: word) { error, synonymModel in
             completionHandler(error,synonymModel)
        }
    }
}
