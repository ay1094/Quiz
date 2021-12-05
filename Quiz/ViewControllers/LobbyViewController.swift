//
//  LobbyViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/16/21.
//

import UIKit

class LobbyViewController: UIViewController {
    let questions: [QuizQuestionObject]
    let triviatype: TriviaType
    init(questions: [QuizQuestionObject], triviatype: TriviaType){
        self.questions = questions
        self.triviatype = triviatype
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let playbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.setTitle("Play", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(gotoGame), for: .touchUpInside)
        return button
    }()
    
    let gameinfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedtext = NSMutableAttributedString(string: "Your Trivia Game is Ready", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        attributedtext.append(NSAttributedString(string: "\n1 minute to answer as many questions as you can. 1 point for each correct answer. -1 point for each incorrect answer", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        label.attributedText = attributedtext
        label.adjustsFontSizeToFitWidth =  true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(playbutton)
        view.addSubview(gameinfo)
        
        NSLayoutConstraint.activate([
            gameinfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameinfo.bottomAnchor.constraint(equalTo: playbutton.topAnchor, constant: -10),
            gameinfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            gameinfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            playbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playbutton.widthAnchor.constraint(equalToConstant: 270),
            playbutton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Do any additional setup after loading the view.
    }
    
    @objc func gotoGame(){
        let qc = QuestionsController(questions: questions, triviatype: triviatype)
        qc.modalPresentationStyle = .fullScreen
        self.present(qc, animated: true, completion: nil)
    }

}
