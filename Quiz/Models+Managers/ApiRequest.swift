//
//  ApiRequest.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/9/21.
//

import Foundation


class ApiRequest {
    let baseurlString = "https://opentdb.com/api.php"
    var fullurl: URL!
    let amount = 10
    let type = "multiple"
    
    var difficulty: String
    let category: Int
    
    init(difficulty: String, category: Int){
        self.difficulty = difficulty
        self.category = category
        generateApiUrl()
    }
    
    private func generateApiUrl(){
        var queryItems = [URLQueryItem(name: "amount", value: String(amount)), URLQueryItem(name: "type", value: type.lowercased()),URLQueryItem(name: "category", value: String(category))]
        if difficulty != "Mixed"{
            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty.lowercased()))
        }
        var urlComps = URLComponents(string: baseurlString)!
        urlComps.queryItems = queryItems
        fullurl = urlComps.url!
        print("url string \(fullurl.absoluteString)")
    }
    
    //fetch data from api
    public func fetchData(completion: @escaping (Result<[QuizQuestionObject], Error>) -> ()){
        print("fetching data")
        let task = URLSession.shared.dataTask(with: fullurl) { data, _, error in
            print("in completion")
//            guard (self != nil) else{
//                print("self is nil")
//                return
//
//            }
            guard let data = data, error == nil else{
                print("error in fetching data")
                completion(.failure(error!))
                return
            }
            do{
                let results = try JSONDecoder().decode(Results.self, from: data)
                print("Count \(results.results.count)")
                for r in results.results{
                    r.choices.append(r.correct_answer)
                    r.choices.shuffle()
                    r.pos_answer = r.choices.firstIndex(where: {$0 == r.correct_answer}) ?? 0
                    //print("Choices: \(r.choices.count)")
                    r.question = r.question.replacingOccurrences(of: "#039;", with: "\'")
                    r.question = r.question.replacingOccurrences(of: "&quot;", with: "")
                    for i in 0..<r.choices.count{
                        r.choices[i] = r.choices[i].replacingOccurrences(of: "#039;", with: "\'")
                        r.choices[i] = r.choices[i].replacingOccurrences(of: "&quot;", with: "")
                    }
                }
                completion(.success(results.results))
            }
            catch{
                print("error in fetching questions")
                print(error)
                completion(.failure(error))
                return
            }
            
        }
        task.resume()
            
    }
}
