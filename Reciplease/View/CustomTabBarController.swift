//
//  CustomTabBarController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    private var _customTabBar: CustomTabBar!
    
    var customTabBar: CustomTabBar{
        get {
            return _customTabBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        initViews()
    }
    
    private func initViews() {
        _customTabBar = CustomTabBar.getFromNib()
        self.view.addSubview(customTabBar)
        setupTabBar()
    }
    
    private func setupTabBar() {
        _customTabBar.setActionSearchTapped {
            self.selectedIndex = 0
        }
        
        _customTabBar.setActionFavoriteTapped {
            self.selectedIndex = 1
        }
        
        setupTabBarAutoLayout()
    }
    
    private func setupTabBarAutoLayout() {
        _customTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        _customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
