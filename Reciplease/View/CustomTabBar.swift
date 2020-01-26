//
//  CustomTabBar.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 16/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//
// swiftlint:disable force_cast

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

    private var actionSearchTapped: () -> Void = {}
    private var actionFavoriteTapped: () -> Void = {}

    func setActionSearchTapped(action: @escaping () -> Void) {
        actionSearchTapped = action
    }

    func setActionFavoriteTapped(action: @escaping () -> Void) {
        actionFavoriteTapped = action
    }

    static func getFromNib() -> CustomTabBar {
        let tabBarView = UINib.init(nibName: "CustomTabBar", bundle: nil).instantiate(withOwner: nil,
                                                                                      options: nil)[0] as! CustomTabBar
        return tabBarView
    }
}
