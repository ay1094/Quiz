//
//  FinishedGameViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/22/21.
//

import UIKit

class FinishedGameViewController: UIViewController {
    
    var gameResult: GameResult
    init(gameResult: GameResult){
        self.gameResult = gameResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //start UI objects
    let topview: UIView = {
        let topview = UIView()
        topview.translatesAutoresizingMaskIntoConstraints = false
        topview.backgroundColor = .systemPurple
        return topview
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    let homebutton: UIButton = {
        let homebutton = UIButton()
        homebutton.translatesAutoresizingMaskIntoConstraints = false
        homebutton.setTitle("Home", for: .normal)
        homebutton.setTitleColor(.black, for: .normal)
        homebutton.layer.borderColor = UIColor.systemPurple.cgColor
        homebutton.layer.borderWidth = 1.0
        homebutton.addTarget(self, action: #selector(toHome), for: .touchUpInside)
        return homebutton
    }()
    
    let resultsbutton: UIButton = {
        let homebutton = UIButton()
        homebutton.translatesAutoresizingMaskIntoConstraints = false
        homebutton.setTitle("Review Questions", for: .normal)
        homebutton.backgroundColor = .white
        homebutton.setTitleColor(.black, for: .normal)
        homebutton.layer.borderColor = UIColor.systemPurple.cgColor
        homebutton.layer.borderWidth = 1.0
        homebutton.addTarget(self, action: #selector(toResults), for: .touchUpInside)
        return homebutton
    }()
    
    let imageContainerView: UIView = {
        let vview = UIView()
        vview.backgroundColor = .green
        vview.translatesAutoresizingMaskIntoConstraints = false
        return vview
    }()
    
    let sponsorimage: UIImageView = {
        let li = UIImageView()
        li.translatesAutoresizingMaskIntoConstraints = false
        li.image = UIImage(named: "sponsor_image")
        li.contentMode = .scaleAspectFit
        return li
    }()
    //end UI objects
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        setTextLabels()
        addSubviews()
        activateConstraints()
    }
    
    
    //hide logoview in landscape due to it being too small
    @objc func rotated(){
        if UIDevice.current.orientation.isLandscape{
            imageContainerView.isHidden = true
        }
        else if UIDevice.current.orientation.isPortrait{
            imageContainerView.isHidden = false
        }
    }
    
    @objc func toHome(){
        let hvc = HomeViewController()
        let nc = UINavigationController(rootViewController: hvc)
        nc.modalPresentationStyle = .fullScreen
        self.present(nc, animated: true)
    }
    
    @objc func toResults(){
        let rvc = ResultsTableViewController(gameResult: gameResult)
        self.present(rvc, animated: true)
    }
    
    private func setTextLabels(){
        scoreLabel.text = "Score \(gameResult.score)"
        let attributedtext = NSMutableAttributedString(string: "Difficulty: \(gameResult.triviatype.difficulty)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        attributedtext.append(NSAttributedString(string: "\nCategory: \(gameResult.triviatype.category)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        dataLabel.attributedText = attributedtext
        
    }
    
    private func addSubviews(){
        view.addSubview(topview)
        view.backgroundColor = .systemBackground
        topview.addSubview(scoreLabel)
        view.addSubview(resultsbutton)
        view.addSubview(homebutton)
        topview.addSubview(dataLabel)
        topview.addSubview(imageContainerView)
        imageContainerView.addSubview(sponsorimage)
    }
    
    
    private func activateConstraints(){
        NSLayoutConstraint.activate([
            topview.widthAnchor.constraint(equalTo: view.widthAnchor),
            topview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            topview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreLabel.topAnchor.constraint(equalTo: topview.topAnchor, constant: 50),
            scoreLabel.centerXAnchor.constraint(equalTo: topview.centerXAnchor),
            dataLabel.centerXAnchor.constraint(equalTo: topview.centerXAnchor),
            dataLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            homebutton.widthAnchor.constraint(equalToConstant: 270),
            homebutton.heightAnchor.constraint(equalToConstant: 30),
            homebutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homebutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resultsbutton.widthAnchor.constraint(equalToConstant: 270),
            resultsbutton.heightAnchor.constraint(equalToConstant: 30),
            resultsbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultsbutton.bottomAnchor.constraint(equalTo: homebutton.topAnchor, constant: -30),
            imageContainerView.centerXAnchor.constraint(equalTo: topview.centerXAnchor, constant: 0),
            imageContainerView.widthAnchor.constraint(equalTo: topview.widthAnchor),
            imageContainerView.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 0),
            imageContainerView.bottomAnchor.constraint(equalTo: topview.bottomAnchor),
            sponsorimage.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor, multiplier: 0.5),
            sponsorimage.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            sponsorimage.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor)
            
        ])
    }

}
