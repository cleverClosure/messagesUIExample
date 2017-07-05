//
//  C.swift
//  DUI0013 messenger
//
//  Created by Tim on 05.07.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit

class ChatLogMessageCell: UICollectionViewCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    let textBubbleView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 15
        v.layer.masksToBounds = true
        v.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return v
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":profileImageView]))
        profileImageView.backgroundColor = UIColor.red

    }
}
