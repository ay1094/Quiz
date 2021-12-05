//
//  Questions.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 10/24/21.
//

import Foundation
import UIKit

class QuestionsController: UIViewController {
    
    
    
    init(questions: [QuizQuestionObject], triviatype: TriviaType){
        self.questions = questions
        self.triviatype = triviatype
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // model variables
    let triviatype: TriviaType
    var questions: [QuizQuestionObject]
    
    
    //state variables
    var score: Int = 0
    var valid = true
    var correct = false
    var timeRemaining = 20
    var questionNumberIndex: Int = 0
    var questions_correct: Int = 0
    
    
    
    //UI variables
    var question: UILabel!
    var displayedScore: UILabel!
    let buttonsview = UIView()
    let resultText = UILabel()
    var timeView = UILabel()
    var answerbuttons = [UIButton]()
    let closeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    //computed properties
    var displayScore: String {
        return "Score: \(score)"
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let hvc = HomeViewController()
        let nc = UINavigationController(rootViewController: hvc)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 1
        closeImage.addGestureRecognizer(tap)
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.textAlignment = .right
        timeView.text = ":\(self.timeRemaining)"
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeRemaining -= 1
            if self.timeRemaining < 10{
                self.timeView.text=":0\(self.timeRemaining)"
                self.timeView.textColor = .red
            }
            else{
                self.timeView.text = ":\(self.timeRemaining)"
            }
            
            if self.timeRemaining == 0{
                timer.invalidate()
                self.valid = false
                self.endofgame()
            }
        }
        view.addSubview(timeView)
        
        

        
        
        displayedScore = UILabel()
        displayedScore.textAlignment = .right
        displayedScore.translatesAutoresizingMaskIntoConstraints = false
        displayedScore.text = displayScore
        view.addSubview(displayedScore)
        
        
        //generating question view
        question = UILabel()
        question.text = questions[0].question
        question.font = question.font.withSize(30)
        question.numberOfLines = 0
        question.adjustsFontSizeToFitWidth = true
        question.adjustsFontForContentSizeCategory = true
        question.minimumScaleFactor = 0.1
        question.translatesAutoresizingMaskIntoConstraints = false
        question.textAlignment = .center
        view.addSubview(question)
        
        
        resultText.text = "+1"
        resultText.alpha = 0
        resultText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultText)
        
        view.addSubview(closeImage)
        
        let buttonsview = UIView()
        buttonsview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsview)
        //buttonsview.backgroundColor = .systemRed
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            timeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            displayedScore.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            displayedScore.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 10),
            question.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            question.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            question.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            question.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            resultText.trailingAnchor.constraint(equalTo: displayedScore.leadingAnchor, constant: -10),
            resultText.topAnchor.constraint(equalTo: displayedScore.topAnchor, constant: 0),
            closeImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            closeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)
            
        ])
            NSLayoutConstraint.activate([
                buttonsview.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 10),
                buttonsview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                buttonsview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                buttonsview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])
        
        
        
        
        
        for i in 0..<4{
            generateButtonandPosition(position: i)
        }
            NSLayoutConstraint.activate([
                answerbuttons[0].leadingAnchor.constraint(equalTo: buttonsview.leadingAnchor),
                answerbuttons[0].topAnchor.constraint(equalTo: buttonsview.topAnchor),
                answerbuttons[2].bottomAnchor.constraint(equalTo: buttonsview.bottomAnchor),
                answerbuttons[2].leadingAnchor.constraint(equalTo: buttonsview.leadingAnchor),
                answerbuttons[1].trailingAnchor.constraint(equalTo: buttonsview.trailingAnchor),
                answerbuttons[1].topAnchor.constraint(equalTo: buttonsview.topAnchor),
                answerbuttons[3].bottomAnchor.constraint(equalTo: buttonsview.bottomAnchor),
                answerbuttons[3].trailingAnchor.constraint(equalTo: buttonsview.trailingAnchor)
            ])
            
        
        for answerbutton in answerbuttons{
            answerbutton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2.2).isActive = true
            answerbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        
    }
    
    func generateButtonandPosition(position: Int){
        let answerbutton = UIButton()
        answerbutton.translatesAutoresizingMaskIntoConstraints = false
        answerbutton.setTitle(questions[questionNumberIndex].choices[position], for: .normal)
        answerbutton.titleLabel?.adjustsFontSizeToFitWidth = true
        answerbutton.titleLabel?.numberOfLines = 0
        answerbutton.titleLabel?.minimumScaleFactor = 0.1
        answerbutton.tag = position
        answerbutton.addTarget(self, action: #selector(displayAnswer), for: .touchUpInside)
        answerbutton.backgroundColor = .white
        answerbutton.layer.borderColor = UIColor.systemPurple.cgColor
        answerbutton.setTitleColor(.black, for: .normal)
        answerbutton.layer.borderWidth = 1
        view.addSubview(answerbutton)
        answerbuttons.append(answerbutton)
    }
    
    @objc func displayAnswer(_ sender: Any){
        if !valid {
            return
        }
        //let startTime = CFAbsoluteTimeGetCurrent()
        valid = false
        guard let buttonans = sender as? UIButton else{
            return
        }
        let user_answer_pos = buttonans.tag
        let correct_answer_pos = questions[questionNumberIndex].pos_answer
        questions[questionNumberIndex].user_answer = questions[questionNumberIndex].choices[user_answer_pos]
        
        
        DispatchQueue.main.async {
            self.answerbuttons[correct_answer_pos].backgroundColor = .green
        }
        
        if user_answer_pos != correct_answer_pos{
            DispatchQueue.main.async {
                self.answerbuttons[user_answer_pos].backgroundColor = .red
                self.resultText.textColor = .systemRed
                self.resultText.text = "-1"
            }
        }
        
        else{
            self.questions_correct += 1
            self.resultText.text = "+1"
            self.resultText.textColor = .systemGreen
        }
        revealIndivScore()
        changeOverallScore()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.updateQuestion()
        }
        
        //updateQuestion()
        valid = true
        //let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        //print("Time elapsed for display answer \(timeElapsed) s.")
    }
    
    private func updateQuestion(){
        questionNumberIndex += 1
        if questionNumberIndex == questions.count{
            endofgame()
        }
        else{
            UIView.transition(with: question,
                          duration: 0.50,
                          options: .transitionCrossDissolve,
            animations: {
                self.question.text = self.questions[self.questionNumberIndex].question
            },
            completion:nil)
            
            //self.question.text = self.questions[self.questionNumberIndex].question
        }
        
        for i in 0..<self.answerbuttons.count{
            self.answerbuttons[i].backgroundColor = .white
        }
        
        for i in 0..<self.answerbuttons.count{
            UIView.transition(with: answerbuttons[i], duration: 0.50, options: .transitionCrossDissolve, animations: {
                self.answerbuttons[i].setTitle(self.questions[self.questionNumberIndex].choices[i], for: .normal)
            }, completion: nil)
//            self.answerbuttons[i].setTitle(self.questions[self.questionNumberIndex].choices[i], for: .normal)
            
        }
    }
    
    
    private func revealIndivScore(){
        UIView.animate(withDuration: 0.25) {
            self.resultText.alpha = 1
        } completion: { done in
            if done{
                UIView.animate(withDuration: 0.25) {
                    self.resultText.alpha = 0
                }
            }
        }

    }
    
    private func changeOverallScore(){
        if correct{
            score += 1
        }
        else{
            score -= 1
        }
        displayedScore.text = displayScore
        
    }
    
    private func endofgame(){
        let accuracy = Double (self.questions_correct) / Double (self.questionNumberIndex)
        let roundedValue = round(accuracy * 100) / 100.0
        CoreDataManager.shared.createNewScore(accuracy: roundedValue, category: triviatype.category, score: Int16(score), difficulty: triviatype.difficulty)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var subset: [QuizQuestionObject] = []
            let acc = AccuracyInformation(questionsCorrect: self.questions_correct, questionsAnswered: self.questionNumberIndex)
            if self.questionNumberIndex != 0{
                subset = Array(self.questions[0 ... self.questionNumberIndex-1])
            }
            let gameResult = GameResult(quizQuestions: subset, score: self.score, triviatype: self.triviatype, accuracyinformation: acc)
            let fgvc = FinishedGameViewController(gameResult: gameResult)
            fgvc.modalPresentationStyle = .fullScreen
            self.present(fgvc, animated: true)
        }
       
    }
    
}
