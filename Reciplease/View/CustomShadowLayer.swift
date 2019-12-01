//
//  CustomShadowLayer.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 01/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomShadowLayer: CAGradientLayer {
    init(view: UIView, shadowRadius: CGFloat) {
        super.init()
        self.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        self.shadowRadius = shadowRadius
        let viewFrame = view.frame
        
        startPoint = CGPoint(x: 0.5, y: 1.0)
        endPoint = CGPoint(x: 0.5, y: 0.0)
        self.frame = CGRect(x: 0.0, y: viewFrame.height - shadowRadius, width: viewFrame.width, height: shadowRadius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
