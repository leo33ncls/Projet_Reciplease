//
//  CustomTabBarController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private var customBar: CustomTabBar!
    
    var customTabBar: CustomTabBar{
        get {
            return customBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.alpha = 0
        self.tabBar.isUserInteractionEnabled = false
        
        initViews()
    }
    
    private func initViews() {
        customBar = CustomTabBar.getFromNib()
        self.view.addSubview(customTabBar)
        setupTabBar()
    }
    
    private func setupTabBar() {
        customBar.setActionSearchTapped {
            self.selectedIndex = 0
        }
        
        customBar.setActionFavoriteTapped {
            self.selectedIndex = 1
        }
        
        setupTabBarAutoLayout()
    }
    
    private func setupTabBarAutoLayout() {
        customBar.translatesAutoresizingMaskIntoConstraints = false
        
        customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
