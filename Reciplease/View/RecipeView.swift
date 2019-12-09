//
//  RecipeView.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 09/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class RecipeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeView: TimeView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RecipeView", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        recipeImageView.layer.addSublayer(CustomShadowLayer(view: recipeImageView, shadowColor: UIColor.black, shadowRadius: 60.0))
    }
    
    func configure(name: String?, ingredients: String?, like: Int, time: Int, imageData: Data?) {
        nameLabel.text = name
        ingredientsLabel.text = ingredients
        timeView.setViewValues(like: like, time: time)
        if let image = imageData {
            recipeImageView.image = UIImage(data: image)
        } else {
            recipeImageView.image = #imageLiteral(resourceName: "recipeDefault")
        }
    }
}
