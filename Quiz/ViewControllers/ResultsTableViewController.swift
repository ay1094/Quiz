//
//  ResultsTableViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/17/21.
//

import UIKit

class ResultsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gameResult: GameResult
    init(gameResult: GameResult){
        self.gameResult = gameResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as! ResultsTableViewCell
        let questionObject = gameResult.quizQuestions[indexPath.section]
        cell.question.text = questionObject.question
        let metadataString = "Difficulty: \(questionObject.difficulty)   Category: \(questionObject.category)"
        cell.metadata.text = metadataString
        if questionObject.correct_answer == questionObject.user_answer {
            cell.info.attributedText = getinfoString(image: "checkmark.circle", text: " \(indexPath.section + 1) Correct")
            cell.info.backgroundColor = .green
            cell.info.textColor = .white
            let answerString = "Your Answer, Correct Answer: \(questionObject.correct_answer)"
            cell.answer.text = answerString
        }
        
        else {
            let answerString = "Your Answer: \(questionObject.user_answer) Correct Answer \(questionObject.correct_answer) "
            cell.answer.text = answerString
            cell.info.attributedText = getinfoString(image: "xmark.circle", text: "\(indexPath.section + 1) Incorrect")
            cell.info.backgroundColor = .red
            cell.info.textColor = .white
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameResult.quizQuestions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    let tv = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in tableview view didload")
        tv.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.identifier)
        view.addSubview(tv)
        // Do any additional setup after loading the view.
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getinfoString(image: String, text: String) -> NSMutableAttributedString{
        let fullString = NSMutableAttributedString(string: text)
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(systemName: image)
        image1Attachment.image?.withTintColor(UIColor.white)
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        return fullString
    }
    
}
