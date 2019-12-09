//
//  TimeView.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 30/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class TimeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var timeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TimeView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        clipsToBounds = true
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
    
    func setViewValues(like: Int, time: Int) {
        ratingImageView.image = #imageLiteral(resourceName: "likeIcon")
        timeImageView.image = #imageLiteral(resourceName: "timeIcon")
        ratingLabel.text = " \(like)"
        if time == 0 {
            timeLabel.text = " /"
        } else {
            timeLabel.text = String(time) + "m"
        }
    }
}
