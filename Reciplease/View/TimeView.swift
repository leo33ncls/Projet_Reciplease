//
//  TimeView.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 30/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class TimeView: UIView {
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    private func setView() {
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
    
    func setViewValues(like: Int, time: Int) {
        likeImageView.image = #imageLiteral(resourceName: "likeIcon")
        timeImageView.image = #imageLiteral(resourceName: "timeIcon")
        likeLabel.text = String(like)
        if time == 0 {
            timeLabel.text = "/"
        } else {
            timeLabel.text = String(time) + "m"
        }
    }
}
