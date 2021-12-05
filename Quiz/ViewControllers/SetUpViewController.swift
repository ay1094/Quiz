//
//  ViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 10/23/21.
//

import UIKit

class SetUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var triviatype = TriviaType(difficulty: "Mixed", category: "General Knowledge")
    let difficulty = ["Mixed", "Easy", "Medium", "Hard"]
    let category = ["General Knowledge", "Entertainment: Books"]
    let strengthpicker = UIPickerView()
    let submitbutton = UIButton()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    var selectedDifficulty: String = "Mixed"
    var selectedTopic: Int = 9
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return difficulty.count
        }
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==0{
            return difficulty[row]
        }
        else{
            return category[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0{
            var label: UILabel
            if let labelview = view as? UILabel{
                label = labelview
            }
            else{
                label = UILabel()
            }
            
            label.text = difficulty[row]
            label.textAlignment = .center
            //label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            //label.font = UIFont(name: "Helvetica", size: 18)
            //label.minimumScaleFactor = 0.9
            
            //label.backgroundColor = .blue
            
            return label
        }
        
        
        else{
            var label: UILabel
            if let labelview = view as? UILabel{
                label = labelview
            }
            else{
                label = UILabel()
            }
            
            label.text = category[row]
            label.textAlignment = .center
            //label.numberOfLines = 0
            //label.numberOfLines = 0
            label.font = UIFont(name: "Helvetica", size: 24)
            label.clipsToBounds = true
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.01
            //label.backgroundColor = .brown
        
            return label
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0{
            return 100
        }
        return pickerView.frame.width - 100 - 10
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("component 0")
            triviatype.difficulty = difficulty[row]
            print("Difficulty \(triviatype.difficulty)")
            selectedDifficulty=difficulty[row]
            print(selectedDifficulty)
        }
        else if component == 1{
            print("component 1")
            triviatype.category = category[row]
            selectedTopic = row + 9
            print("Category \(triviatype.category)")
            print("Selected Topic: \(selectedTopic)")
        }
    }
    
    let child = SpinnerViewController()
    
    @objc func goToQuiz(){
        print("in go to quiz")
        let apirequest = ApiRequest(difficulty: selectedDifficulty, category: selectedTopic)
        apirequest.fetchData(){ [weak self] result in
            guard let strongself = self else{
                print("self is nil")
                return
            }
            switch result{
            case .failure(let err):
                //guard let strongself = self else{return}
                print("failure")
                print(err)
                strongself.child.willMove(toParent: nil)
                strongself.child.view.removeFromSuperview()
                strongself.child.removeFromParent()
                DispatchQueue.main.async {
                    strongself.adderrormessage()
                }
                
            case .success(let results):
                print("success")
                //guard let strongself = self else{return}
               
                DispatchQueue.main.async {
                    let lvc = LobbyViewController(questions: results, triviatype: strongself.triviatype)
                    strongself.navigationController?.pushViewController(lvc, animated: true)
                }
                
            }

        }
        
        createSpinnerView()
        
    }
    
    private func adderrormessage(){
        print("in add error")
        strengthpicker.removeFromSuperview()
        submitbutton.removeFromSuperview()
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.font = UIFont.systemFont(ofSize: 24)
        message.text = "Unable to load quiz."
        NSLayoutConstraint.activate([
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        view.backgroundColor = .systemBackground
        view.addSubview(submitbutton)
        submitbutton.backgroundColor = .systemPurple
        submitbutton.center.x = view.center.x
        submitbutton.setTitle("SUBMIT", for: .normal)
        submitbutton.setTitleColor(.white, for: .normal)
        submitbutton.translatesAutoresizingMaskIntoConstraints = false
        submitbutton.addTarget(self, action: #selector(goToQuiz), for: .touchUpInside)
        view.addSubview(submitbutton)
        
        
        
    
        strengthpicker.delegate = self
        strengthpicker.dataSource = self
        strengthpicker.translatesAutoresizingMaskIntoConstraints = false
        //strengthpicker.backgroundColor = .systemPurple
        view.addSubview(strengthpicker)
        
        let title : UILabel = {
            let t = UILabel()
            let attributedtext = NSMutableAttributedString(string: "Choose Trivia Type", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
            attributedtext.append(NSAttributedString(string: "\n\n\nDifficulty + Category", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            t.attributedText = attributedtext
            t.textAlignment = .center
            t.numberOfLines = 0
            t.adjustsFontSizeToFitWidth = true
            t.adjustsFontForContentSizeCategory = true
            return t
        }()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            submitbutton.widthAnchor.constraint(equalToConstant: 200),
            submitbutton.heightAnchor.constraint(equalToConstant: 50),
            submitbutton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            submitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            strengthpicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //strengthpicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            strengthpicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            strengthpicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
            //strengthpicker.topAnchor.constraint(equalTo: title.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            title.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80)
            
        ])
        
    }
    func createSpinnerView() {
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    


}

