//
//  TableViewCell.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/1/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "cell"
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .left
        return dateLabel
    }()
    let categoryLabel:UILabel={
        let categoryLabel = UILabel()
        categoryLabel.textAlignment = .center
        return categoryLabel
    }()
    let scoreLabel = UILabel()
    let accuracyLabel = UILabel()
    let difficultyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("In init of table view cell")
//        contentView.backgroundColor = .blue
        //dateLabel.text = "9/24"
        
        
        
       // categoryLabel.text = "Entertainment/Books"
        categoryLabel.adjustsFontSizeToFitWidth = true
       
        
        //scoreLabel.text = "20"
       
       //accuracyLabel.text = "0.95"
        
       // difficultyLabel.text = "Easy"
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(accuracyLabel)
        contentView.addSubview(difficultyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let textHeight =  contentView.frame.size.height * 0.90
        dateLabel.frame = CGRect(x: 10, y: 5, width: contentView.frame.size.width * 0.10, height: textHeight)
        categoryLabel.frame = CGRect(x: dateLabel.frame.maxX, y: 5, width: contentView.frame.size.width * 0.50 - 10, height: textHeight)
        difficultyLabel.frame = CGRect(x: categoryLabel.frame.maxX, y: 5, width: contentView.frame.size.width * 0.20, height: textHeight)
        scoreLabel.frame = CGRect(x: difficultyLabel.frame.maxX, y: 5, width: contentView.frame.size.width * 0.10, height: textHeight)
        accuracyLabel.frame = CGRect(x: scoreLabel.frame.maxX, y: 5, width: contentView.frame.size.width * 0.10, height: textHeight)
    }
    
    
}
