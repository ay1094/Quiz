//
//  HomeViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/7/21.
//

import UIKit

class HomeViewController: UIViewController {

    let chooseQuizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(createGame), for: .touchUpInside)
        return button
    }()
    
    let highScoresButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Stats", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewHighScores), for: .touchUpInside)
        button.layer.borderWidth = 1.0
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let navbarheight = self.navigationController?.navigationBar.frame.height ?? 0.0
        let logoview = LogoView()
        view.addSubview(logoview)
        logoview.translatesAutoresizingMaskIntoConstraints = false
        logoview.backgroundColor = .systemPurple
        view.addSubview(chooseQuizButton)
        view.addSubview(highScoresButton)
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        title = "Trivia"
        
        
        
        NSLayoutConstraint.activate([
            logoview.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoview.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            logoview.bottomAnchor.constraint(equalTo: chooseQuizButton.topAnchor),
            chooseQuizButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            chooseQuizButton.bottomAnchor.constraint(equalTo: highScoresButton.topAnchor, constant: -10),
            chooseQuizButton.widthAnchor.constraint(equalToConstant: 270),
            chooseQuizButton.heightAnchor.constraint(equalToConstant: 40),
            
            highScoresButton.leadingAnchor.constraint(equalTo:chooseQuizButton.leadingAnchor),
            highScoresButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            highScoresButton.widthAnchor.constraint(equalToConstant: 270),
            highScoresButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    

  
    @objc private func createGame(){
        print("tapped line 72")
        let vc = SetUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc private func viewHighScores(){
        let vc = TableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
