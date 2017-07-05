//
//  ChatsCell.swift
//  DUI0013 messenger
//
//  Created by Tim on 01.07.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ?  UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            name.textColor = isHighlighted ?  UIColor.white : UIColor.black
            timeLabel.textColor = isHighlighted ?  UIColor.white : UIColor.black
            previewMessage.textColor = isHighlighted ?  UIColor.white : UIColor.black
        }
    }
    
    var message: Message? {
        didSet {
            name.text = message?.friend?.name
            previewMessage.text = message?.text
            if let userpicName = message?.friend?.profileImageName {
                profileImage.image = UIImage(named: userpicName)
            }
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                let elapsedTimeInSeconds = NSDate().timeIntervalSince(date as Date)
                let secondsInDay: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSeconds > 7 * secondsInDay {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elapsedTimeInSeconds > secondsInDay {
                    dateFormatter.dateFormat = "EEE"
                } 
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
        }
    }
    
    let profileImage: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "conor")
        v.layer.cornerRadius = 30
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let name: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightUltraLight)
        l.text = "Conor Mcgregor"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let previewMessage: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightUltraLight)
        l.text = "They are not on my level"
        l.numberOfLines = 2
        l.textColor = UIColor.darkGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dividerLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .lightGray
        return v
    }()
    
    let timeLabel: UILabel = {
        let l = UILabel()
        l.text = "16:08"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .lightGray
        l.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightUltraLight)
        l.textAlignment = .right
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(profileImage)
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage]))
        addSubview(name)
        addSubview(previewMessage)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(60)]-6-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : profileImage, "v1": name]))
        
        addConstraint(NSLayoutConstraint(item: name, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .top, multiplier: 1.3, constant: 0))
        addConstraint(NSLayoutConstraint(item: previewMessage, attribute: .leadingMargin, relatedBy: .equal, toItem: name, attribute: .leadingMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: previewMessage, attribute: .top, relatedBy: .equal, toItem: name, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: previewMessage, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: previewMessage, attribute: .bottom, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 0))
        addSubview(dividerLine)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : dividerLine]))
        addConstraint(NSLayoutConstraint(item: dividerLine, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: dividerLine, attribute: .left, relatedBy: .equal, toItem: profileImage, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: dividerLine, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0))
        addSubview(timeLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(70)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : timeLabel]))
        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: name, attribute: .top, multiplier: 1, constant: 0))
    }
}
