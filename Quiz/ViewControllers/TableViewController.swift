//
//  TableViewController.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/1/21.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
    
    let games = CoreDataManager.shared.getScores()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let game = games[indexPath.item]
        let acc = String(format: "%.00f", game.accuracy*100)
        cell.accuracyLabel.text = acc
        if let date = game.date{
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month], from: date)
            let month = components.month
            let components1 = calendar.dateComponents([.day], from: date)
            let dayOfMonth = components1.day
            if let m = month, let d = dayOfMonth{
                cell.dateLabel.text="\(m)-\(d)"
            }
        }
        
        cell.categoryLabel.text = game.category
        cell.difficultyLabel.text = game.difficulty
        cell.scoreLabel.text = "\(game.score)"
        return cell
    }
    

    let tv = UITableView()
    
    let headertexts = ["Date", "Category", "Difficulty", "Score", "%"]
    
    var labels = [UILabel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In tableview viewdidload")
        tv.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
//        tv.backgroundColor = .systemPurple
        tv.dataSource = self
        view.addSubview(tv)
        let headerview = UIView()
        setupheaderlabels()
        for label in labels{
            headerview.addSubview(label)
        }
        headerview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        let textHeight =  headerview.frame.size.height * 0.90
        labels[0].frame = CGRect(x: 10, y: 5, width: view.frame.size.width * 0.10, height: textHeight)
        tv.tableHeaderView = headerview
        
       // tv.tableHeaderView?.backgroundColor = .systemPurple
        
        labels[1].frame = CGRect(x: labels[0].frame.maxX, y: 5, width: view.frame.size.width * 0.50 - 10, height: textHeight)
        headerview.addSubview(labels[1])


        labels[2].frame =  CGRect(x: labels[1].frame.maxX, y: 5, width: view.frame.size.width * 0.20, height: textHeight)
        headerview.addSubview(labels[2])

        labels[3].frame = CGRect(x: labels[2].frame.maxX, y: 5, width: view.frame.size.width * 0.10, height: textHeight)
        headerview.addSubview(labels[3])


       labels[4].frame = CGRect(x: labels[3].frame.maxX, y: 5, width: view.frame.size.width * 0.10, height: textHeight)
        headerview.addSubview(labels[4])
        
        
        
        print("line 21")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidLayoutSubviews() {
        tv.frame = view.bounds
        
    }
    
    func setupheaderlabels(){
        for i in 0..<headertexts.count{
            let label = UILabel()
            label.text = headertexts[i]
            label.adjustsFontSizeToFitWidth = true
            label.text = headertexts[i]
            label.font = UIFont.boldSystemFont(ofSize: 12.0)
            label.textAlignment = .center
            //label.textColor = .white
            labels.append(label)
            
        }
        
        
    }
    
    

   
}
