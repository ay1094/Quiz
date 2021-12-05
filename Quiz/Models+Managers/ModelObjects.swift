//
//  ApiResponseObjects.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/9/21.
//

import Foundation



class Results: Decodable {
    var response_code: Int
    var results: [QuizQuestionObject]
}
class QuizQuestionObject: Decodable{
    var category: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var choices: [String]
    var pos_answer: Int = 0
    var user_answer: String = ""
    
    private enum CodingKeys: String, CodingKey { case category, difficulty, question, correct_answer, choices = "incorrect_answers" }
}



struct TriviaType{
    var difficulty: String
    var category: String
}

struct UserResults{
    var score: Int
    var accuracy: Double
    var questions: [UserQuestion]
}

struct UserQuestion{
    var question: String
    var correct_answer: String
    var user_answer: String
}

struct GameResult{
    var quizQuestions: [QuizQuestionObject]
    var score: Int
    var triviatype: TriviaType
    var accuracyinformation: AccuracyInformation
}

struct AccuracyInformation{
    var questionsCorrect: Int
    var questionsAnswered: Int
}

public enum Result<T,U>{
    case success(T)
    case failure(U)
}
