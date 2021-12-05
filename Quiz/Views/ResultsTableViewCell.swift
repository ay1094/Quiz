//
//  ResultsTableViewCell.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/17/21.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let identifier = "resultstableview"
    
    
    let question: UILabel = {
        let question = UILabel()
        question.textAlignment = .left
        question.numberOfLines = 0
        question.adjustsFontSizeToFitWidth = true
        question.font = UIFont.systemFont(ofSize: 24)
        question.minimumScaleFactor = 0.1
        question.lineBreakMode = .byClipping
        //question.backgroundColor = .brown
        question.translatesAutoresizingMaskIntoConstraints = false
        return question
    }()
    
    let info: UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        
//        // create an NSMutableAttributedString that we'll append everything to
//        let fullString = NSMutableAttributedString(string: "Start of text")
//
//        // create our NSTextAttachment
//        let image1Attachment = NSTextAttachment()
//        image1Attachment.image = UIImage(named: "awesomeIcon.png")
//
//        // wrap the attachment in its own attributed string so we can append it
//        let image1String = NSAttributedString(attachment: image1Attachment)
//
//        // add the NSTextAttachment wrapper to our full string, then add some more text.
//        fullString.append(image1String)
//        fullString.append(NSAttributedString(string: "End of text"))
//
//        // draw the result in a label
//       // yourLabel.attributedText = fullString
        //info.backgroundColor = .green
        return info
    }()
    
    let metadata: UILabel = {
        let answer = UILabel()
        answer.font = UIFont.systemFont(ofSize: 12)
        answer.adjustsFontForContentSizeCategory = true
        answer.numberOfLines = 0
        answer.minimumScaleFactor = 0.4
        answer.backgroundColor = .white
        answer.translatesAutoresizingMaskIntoConstraints = false
        return answer
    }()
    
    let answer: UILabel = {
        let answer = UILabel()
        answer.font = UIFont.systemFont(ofSize: 12)
        answer.adjustsFontForContentSizeCategory = true
        answer.numberOfLines = 0
        //answer.backgroundColor = .orange
        answer.minimumScaleFactor = 0.4
        answer.translatesAutoresizingMaskIntoConstraints = false
        return answer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("In init of table view cell")
        //contentView.backgroundColor = .blue
        contentView.addSubview(question)
        contentView.addSubview(info)
        contentView.addSubview(answer)
        contentView.addSubview(metadata)
        
        NSLayoutConstraint.activate([
            info.topAnchor.constraint(equalTo: contentView.topAnchor),
            info.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            info.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10),
            metadata.topAnchor.constraint(equalTo: info.bottomAnchor),
            metadata.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            metadata.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10),
            question.topAnchor.constraint(equalTo: metadata.bottomAnchor),
            question.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            question.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            answer.topAnchor.constraint(equalTo: question.bottomAnchor),
            answer.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            answer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
