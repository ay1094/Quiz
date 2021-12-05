//
//  LogoView.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/14/21.
//

import UIKit

class LogoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let title: UILabel = {
        let title = UILabel()
        //title.text = "Over 4000 questions and 20+ categories"
        let attributedtext = NSMutableAttributedString(string: "Ultimate Trivia", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        attributedtext.append(NSAttributedString(string: "\nOver 400 questions and 20 subjects to choose from", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        title.attributedText = attributedtext
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontForContentSizeCategory = true
        title.textAlignment = .center
        return title
    }()
    
    let logoimage: UIImageView = {
        let li = UIImageView()
        li.translatesAutoresizingMaskIntoConstraints = false
        li.image = UIImage(named: "logo_image")
        return li
    }()
    
    let sponsortext: UILabel = {
        let title = UILabel()
        //title.text = "Over 4000 questions and 20+ categories"
        let attributedtext = NSMutableAttributedString(string: "powered by", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        title.attributedText = attributedtext
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.adjustsFontForContentSizeCategory = true
        title.textAlignment = .center
        return title
    }()
    
    
    
    let sponsorimage: UIImageView = {
        let li = UIImageView()
        li.translatesAutoresizingMaskIntoConstraints = false
        li.image = UIImage(named: "sponsor_image")
        li.contentMode = .scaleAspectFit
        return li
    }()
    
    
    
    
    override init(frame: CGRect) {
          super.init(frame: frame)
        print("from frameCGRect")
          didLoad()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
      }

      func didLoad() {
        //Place your initialization code here
        self.addSubview(title)
        self.addSubview(logoimage)
        let sponsorview = UIView()
        sponsorview.backgroundColor = .systemGreen
        self.addSubview(sponsorview)
        self.addSubview(sponsorimage)
        self.addSubview(sponsortext)
        sponsorview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoimage.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            logoimage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            logoimage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            logoimage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            title.bottomAnchor.constraint(equalTo: logoimage.topAnchor),
            sponsorview.topAnchor.constraint(equalTo: logoimage.bottomAnchor),
            sponsorview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sponsorview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sponsorview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sponsorimage.centerYAnchor.constraint(equalTo: sponsorview.safeAreaLayoutGuide.centerYAnchor),
            sponsorimage.heightAnchor.constraint(equalTo: sponsorview.heightAnchor, multiplier: 0.5),
            sponsorimage.centerXAnchor.constraint(equalTo: sponsorview.centerXAnchor),
            sponsortext.topAnchor.constraint(equalTo: logoimage.bottomAnchor, constant: 0),
            sponsortext.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            sponsortext.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            sponsortext.bottomAnchor.constraint(equalTo: sponsorimage.topAnchor),
            
        ])
      }

      override func layoutSubviews() {
         super.layoutSubviews()

         //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
      }

      override func updateConstraints() {
        super.updateConstraints()
        //self.translatesAutoresizingMaskIntoConstraints = false
      }
    
    
    
    

}
