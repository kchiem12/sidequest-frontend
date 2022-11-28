//
//  tabBarViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit

class tabBarViewController: UIViewController {
    
    let tabBar = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab()
        
    }
    
    func tab() {
        tabBar.tabBar.tintColor = UIColor.red
        let firstVC = HomePage()
        let secondVC = AddJobViewController()
        
//        let item1 = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//
//        firstVC.tabBarItem = item1
//        secondVC.tabBarItem = item2
        
        tabBar.viewControllers = [firstVC, secondVC]
        
        view.addSubview(tabBar.view)
    }
    
}
