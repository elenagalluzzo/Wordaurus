//
//  SynonymApi.swift
//  Wordaurus
//
//  Created by Elena Galluzzo on 2023-04-18.
//

import Foundation

class SynonymApi: NSObject {
    static let sharedInstance = SynonymApi()
    
    func callSynonymApi(word: String, completionHandler: @escaping(_ error : Error?, _ synonymModel: SynonymModel?)->()) {
        
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let keysDict =  NSDictionary(contentsOfFile: path), let apiKey = keysDict["apiKey"] as? String else {
            completionHandler(nil, nil)
            return
        }
        
        let headers = [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": "english-synonyms.p.rapidapi.com"
        ]
        
        
        guard let url = URL(string: "https://english-synonyms.p.rapidapi.com/\(word)")
        else {
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error)  in
            if (error != nil) {
                completionHandler(error, nil)
            } else {
                guard let data = data else { return }
                do {
                    let synonymObject = try JSONDecoder().decode(SynonymModel.self, from: data)
                    completionHandler(nil, synonymObject)
                } catch let error {
                    completionHandler(error, nil)
                }
            }
        }
        dataTask.resume()
        
    }
    
}
    
    
    
    
