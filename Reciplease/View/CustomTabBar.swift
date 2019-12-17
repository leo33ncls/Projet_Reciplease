//
//  CustomTabBar.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomTabBar: UIView {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchButton.setTitleColor(UIColor.white, for: .normal)
        favoriteButton.setTitleColor(UIColor.gray, for: .normal)
        actionSearchTapped()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        favoriteButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.setTitleColor(UIColor.gray, for: .normal)
        actionFavoriteTapped()
    }
    
    private var actionSearchTapped: ()->() = {}
    private var actionFavoriteTapped: ()->() = {}
    
    func setActionSearchTapped(action: @escaping ()->()) {
        actionSearchTapped = action
    }
    
    func setActionFavoriteTapped(action: @escaping ()->()) {
        actionFavoriteTapped = action
    }
    
    static func getFromNib() -> CustomTabBar {
        let tabBarView = UINib.init(nibName: "CustomTabBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomTabBar
        return tabBarView
    }
}
